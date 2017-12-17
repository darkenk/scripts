from unittest import TestCase
from project_creator import ProjectCreator
import os
import shutil


class TestProjectCreator(TestCase):

    def test_ifDirectoryIsCreatedCorrectly(self):
        buildLog = "empty"
        emptyFile = open(buildLog, "w")
        emptyFile.close()
        rootDir = "src"
        dir = rootDir + "/f"
        shutil.rmtree(rootDir, True)
        pc = ProjectCreator(["-d", dir, "-p", "testProject", "-f", buildLog])
        pc.exec()
        self.assertTrue(os.path.isdir(dir))
        shutil.rmtree(rootDir, True)
        os.remove(buildLog)


    def test_exec(self):
        return
