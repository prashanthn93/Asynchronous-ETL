from types import NotImplementedType
import unittest
from unittest.mock import MagicMock
import os
import sys
from date_formatter import DateFormatter 

#sys.path.append(os.path.abspath("./testGetTestData.py"))

from extract import *

class TestDateFormatter(unittest.TestCase):

    def test_getTimeFromDTStamp(self):
        formatter = DateFormatter()

        time = formatter.getTimeFromDTStamp("2021-11-29T15:48:55.430+0000")
        self.assertEqual(time, "15:48:55")

    def test_getDateFromDTStamp(self):
        formatter = DateFormatter()

        date = formatter.getDateFromDTStamp("2021-11-29T15:48:55.430+0000")
        self.assertEqual(date, "2021-11-29")

    def test_getFormattedDate(self):
        formatter = DateFormatter()

        date = formatter.getFormattedDate("2021-11-29T15:48:55.430+0000")
        self.assertEqual(date, "2021-11-29 15:48:55")



if __name__ == '__main__':
    unittest.main()