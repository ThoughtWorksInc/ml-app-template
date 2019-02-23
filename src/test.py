from unittest import TestCase


class TestSimpleExample(TestCase):
    def test_1_should_equal_1(self):
        self.assertEqual(1, 1)

    def test_1_plus_1_should_equal_2(self):
        self.assertEqual(1 + 1, 2)
