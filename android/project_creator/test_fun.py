from unittest import TestCase
import project_creator


class TestFun(TestCase):
    def test_fun(self):
        self.assertEqual(project_creator.fun(3), 4);
