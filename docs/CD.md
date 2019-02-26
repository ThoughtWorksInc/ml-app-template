# Setting up your CD pipeline

During the workshop, we will walk you through how to configure a CD pipeline for your project. We will specify our CD pipeline in `.circleci/config.yml`. And you can refer to `.circleci/config.heroku.reference.yaml` for the complete solution, if you wish to.

### Steps to do before the workshop
- Create CircleCI account: https://circleci.com/ (free)
- Create heroku account: https://heroku.com/ (free)
- Fork this repository: https://github.com/davified/ci-workshop-app

### One-time manual steps
#### CircleCI
- Create circleci project. Visit https://circleci.com/dashboard, login and click on 'Add Projects' on the left panel. Click on 'Set up project' for `ci-workshop-app`

#### Heroku
- Login to heroku by running: `heroku login` (complete authentication by clicking on the browser. if the browser doesn't open up automatically, you can copy and paste the link manually)
- Create a heroku project for app (staging): `heroku create ci-workshop-app-<YOUR_NAME>-staging`
- Create a heroku project for app (prod): `heroku create ci-workshop-app-<YOUR_NAME>-prod`
- If you encounter problems creating the 2 apps using ther `heroku` cli, you can create the 2 apps on the heroku website: https://dashboard.heroku.com/new-app
___

### Let's build our CD pipeline!

#### Iteration 1: Hello world

Let's create a simple pipeline to run 2 commands: `echo 'hello'` and `echo 'goodbye'`

**Your tasks**
- In your terminal, run:
  - `echo "HELLO WORLD!!!"`
  - `echo "GOODBYE!!!"`
- Copy and paste the following snippet in `.circleci/config.yml`
- Add, commit and push your changes to your repository:
  - `git add .circleci/config.yml`
  - `git commit -m "Creating pipeline to run hello world commands"`
  - `git push -u origin master`

```yaml
# .circleci/config.yml
version: 2
jobs:
  hello_world:    # name of job
    docker:       # what docker image to use when running this job 
      - image: circleci/python:3.6.1
    working_directory: ~/repo
    steps:
      - run:      # my first step
          name: hello
          command: echo "HELLO WORLD!!!"
      - run:      # my second step
          name: bye
          command: echo "GOODBYE!!!"

workflows:
  version: 2
  my_ci_pipeline:
    jobs:
      - hello_world
```

___

#### Iteration 2: Train and test

Let's extend to pipeline to (i) run unit tests, (ii) train the model, and (iii) run metrics tests on the model.

**Your tasks**
- In your code editor, open and read the following bash scripts:
  - `bin/test.sh`
  - `bin/train_model.sh`
  - `bin/test_model_metrics.sh`
- Get a feel of what each bash script is doing by running them:
  - Start a bash terminal in your container: `docker run -it -v $(pwd):/home/ci-workshop-app -p 8080:8080 ci-workshop-app bash`
  - In the terminal, run each of the 3 scripts above (e.g. `bin/test.sh`)
- Copy and paste the following snippet in `.circleci/config.yml`
- git add, commit and push your changes to your repository

```yaml
# .circleci/config.yml
version: 2
jobs:
  train_and_test:
    docker:
      - image: circleci/python:3.6.1
    working_directory: ~/repo
    steps:
      - checkout              # checkout source code
      - restore_cache:        # load cache (to save time)
          keys:
            - v1-dependencies-{{ checksum "requirements.txt" }}
            # fallback to using the latest cache if no exact match is found
            - v1-dependencies-
      - run:
          name: install dependencies
          command: bin/install_dependencies.sh
      - save_cache:           # save cache (to save time)
          paths:
            - .venv
          key: v1-dependencies-{{ checksum "requirements.txt" }}
      - run:
          name: run unit tests
          command: bin/test.sh
      - run:
          name: train model
          command: bin/train_model.sh
      - run:
          name: run model metrics tests
          command: bin/test_model_metrics.sh
      - persist_to_workspace:   # save artifact
          root: .
          paths:
            - .

workflows:
  version: 2
  my_ci_pipeline:
    jobs:
      - train_and_test
```

___

#### Iteration 3: Deploy to staging and production

Let's deploy our app to staging and production!

**Your tasks**
- In your code editor, open and read the following bash scripts:
  - `bin/deploy_to_heroku.sh` - we wrote this script. this is how you can deploy an app to heroku
  - `Procfile` - This is a simple shell script which heroku will run when it starts your application
- Copy and paste the following snippet in `.circleci/config.yml`. Note:
  - Replace `ci-workshop-app-bob-staging` and `ci-workshop-app-bob-prod` with the names of your staging and prod apps
  - Keep the `train_and_test` configuration which you pasted in your previous task.
  - Ensure indentation matches what you pasted in your previous task! Otherwise CircleCI will not be happy.
- git add, commit and push your changes to your repository


```yaml
# .circleci/config.yml
version: 2
jobs:
  train_and_test:
    # ... same as previous code snippet
  deploy_staging:
    docker:
      - image: circleci/python:3.6.1
    steps:
      - attach_workspace:
          at: .
      - run:
          name: deploy app to staging
          command: bin/deploy_to_heroku.sh ci-workshop-app-bob-staging
  deploy_prod:
    docker:
      - image: circleci/python:3.6.1
    steps:
      - attach_workspace:
          at: .
      - run:
          name: deploy app to prod
          command: bin/deploy_to_heroku.sh ci-workshop-app-bob-prod


workflows:
  version: 2
  my_ci_pipeline:
    jobs:
      - train_and_test
      - deploy_staging:
          requires:
            - train_and_test
      - trigger_deploy:
          type: approval
          requires:
            - deploy_staging
      - deploy_prod:
          requires:
            - trigger_deploy
```

___

#### Iteration 4: Deploy to production (for real)

- In your terminal, generate a heroku auth token and copy the 'Token' value : `heroku authorizations:create`
- On CircleCI webpage, go to your project settings (click on the gear icon on your project) and click on 'Environment Variables' on the left panel. Add the following variable:
  - Name: HEROKU_AUTH_TOKEN
  - Value: (paste value created from previous step)
- On CircleCI's workflows page, find the failed workflow and click on 'Rerun' 