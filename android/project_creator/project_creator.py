from argparse import ArgumentParser
import os
import sys
import shutil
from Project import Project
from compiler_parser import CompilerParser


class ProjectCreator:
    def __init__(self, args=None):
        parser = ArgumentParser()
        parser.add_argument("-p", nargs=1, help="project name", required=True)
        parser.add_argument("-d", nargs=1, help="where create project", required=True)
        parser.add_argument("-f", nargs=1, help="file with build output")
        parser.add_argument("-sdkVersion", nargs=1, type=int, help="sdk version", default=22)
        parser.add_argument("-compileSdkVersion", nargs=1, type=int, help="sdk version", default=26)
        parsed_args = parser.parse_args(args)
        self.output = parsed_args.d[0]
        recurse = len(parsed_args.d[0].split("/"))
        self.project = Project(parsed_args.compileSdkVersion, parsed_args.sdkVersion, "../" * recurse,
                               parsed_args.p[0])
        input = sys.stdin
        if parsed_args.f is not None:
            input = open(parsed_args.f[0])
        self.parser = CompilerParser(input)

    def exec(self):
        self.parser.parse()
        for f in self.parser.projectObjects:
            self.project.addFile(f)
        shutil.rmtree(self.output, True)
        os.makedirs(self.output)
        self.saveFile("build.gradle", self.project.getGradle())
        self.saveFile("AndroidManifest.xml", self.project.getManifest())
        self.saveFile("CMakeLists.txt", self.project.getCmake())
        return

    def saveFile(self, file, content):
        f = open(self.output + "/" + file, "w")
        f.write(content)
        f.close()


if __name__ == '__main__':
    p = ProjectCreator()
    p.exec()