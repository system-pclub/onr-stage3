#!/usr/bin/env python
# -*- coding: utf-8 -*-

import webbrowser, os
import time


def main():

    # TODO: read states
    print("reading raw state data...........")
    time.sleep(0.2)

    # generate options
    print("generate state machine graph......")
    path = os.path.dirname(os.path.abspath(__file__))
    filename = path + "/index.html"
    time.sleep(0.1)

    # open a web browser and load the state machine graph
    print("load state machine graph......")
    time.sleep(0.1)
    webbrowser.open(filename)


if __name__ == '__main__':
    main()
