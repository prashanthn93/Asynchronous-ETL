from types import NotImplementedType
import unittest
from unittest.mock import MagicMock
import os
import sys
#from .extract import Extract

#sys.path.append(os.path.abspath("./testGetTestData.py"))

from extract import *

class TestExtract(unittest.TestCase):

    def test_func_extract(self):
        extract = Extract()

        result = extract.extract()
        self.assertEqual(len(result), 1)
        self.assertEqual()



if __name__ == '__main__':
    unittest.main()