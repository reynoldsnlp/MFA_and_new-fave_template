import importlib.abc
import importlib.util
import types
import sys

STUB_PREFIXES = ("kalpy", "_kalpy", "pynini", "pywrapfst", "_pywrapfst")


class StubModule(types.ModuleType):
    def __getattr__(self, name):
        value = type(name, (), {"__init__": lambda self, *args, **kwargs: None})
        setattr(self, name, value)
        return value


class MissingDependencyStubFinder(importlib.abc.MetaPathFinder, importlib.abc.Loader):
    def find_spec(self, fullname, path=None, target=None):
        if any(fullname == p or fullname.startswith(p + ".") for p in STUB_PREFIXES):
            return importlib.util.spec_from_loader(fullname, self)
        return None

    def create_module(self, spec):
        module = StubModule(spec.name)
        module.__path__ = []
        return module

    def exec_module(self, module):
        return None


sys.meta_path.insert(0, MissingDependencyStubFinder())

import montreal_forced_aligner  # noqa: E402
import new_fave  # noqa: E402

print(f"Imported Montreal-Forced-Aligner via module '{montreal_forced_aligner.__name__}'")
print(f"Imported new-fave via module '{new_fave.__name__}'")

print("Toy import check passed.")
