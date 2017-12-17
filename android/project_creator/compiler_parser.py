from argparse import ArgumentParser
import re

class FileObject:
    def __init__(self, include, warnings, system, defines, source, output):
        self.includes = self.createStringList(include)
        self.warnings = self.createStringList(warnings)
        self.systemIncludes = self.createStringList(system)
        self.defines = self.createStringList(defines)
        self.output = output
        self.source = source

    def createStringList(self, list):
        ret = []
        for item in list:
            if len(item) != 0:
                ret.append(item[0])
        return ret


class FileExec:
    def __init__(self, objects, output):
        self.objects = objects
        self.output = output


class CompilerParser:

    compilerPrefix = ["bin/clang++", "bin/clang", "bin/gcc", "bin/g++"]
    sourcePostfix = ["cpp", "cc", "c", "cxx"]

    def __init__(self, input):
        self.input = input
        self.projectObjects = []

    def parse(self):
        for line in self.input:
            objectFile = self.parseLine(line)
            if objectFile is not None:
                self.projectObjects.append(objectFile)

    def parseLine(self, line):
        begin = self.validLine(line)
        if begin == -1:
            return None
        parser = ArgumentParser()
        parser.add_argument('-I', nargs='*', action='append')
        parser.add_argument('-W', nargs='*', action='append')
        parser.add_argument('-isystem', nargs='*', action='append')
        parser.add_argument('-o', nargs=1, action='append')
        parser.add_argument('-D', nargs='*', action='append')

        args, unknown = parser.parse_known_args(line[begin:].split())

        f = None
        if args.o[0][0][-2:] == ".o":
            src = self.findSource(line)
            if src is not None:
                f = FileObject(args.I, args.W, args.isystem, args.D, src, args.o[0][0])
        return f

    def validLine(self, line):
        begin = -1
        for i in self.compilerPrefix:
            begin = line.find(i)
            if begin != -1:
                break
        return begin

    def findSource(self, line):
        for postfix in self.sourcePostfix:
            ret = re.search("[^\s]+\." + postfix, line)
            if ret is not None:
                return ret.group(0)
        return None

