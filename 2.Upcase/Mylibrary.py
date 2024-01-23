

import logging
from robot.api import logger
from robot.output import librarylogger
from robot.running.context import EXECUTION_CONTEXTS

class Mylibrary:

    def divide (self, a,b):
        c= int(a)/int(b)
        return c
    
    def test(self, a, b):
        print(type(a))
        if(a == b):
            logger.console(a)
        else:
            logger.console(b)
        return a

    def String_Conver(self, a):
        b = a.replace('\n', '')
        c = b.replace(' ', '')
        d = c.replace(',]', '')
        f = d.replace('[', '')
        g = f.replace('0x', '')
        x = list(g.split(","))
        my_ints = [int(i, 16) for i in x]
        char_list = [chr(y) for y in my_ints]
        
        #logger.console(type(char_list))
        #logger.console(char_list)
        return char_list
    
    def Create_List_String(self, a):
        list_str = list(a)
        #logger.console(list_str)
        return list_str
    
    def Get_Length_String(self, a):
        #logger.console(len(a))
        return len(a)