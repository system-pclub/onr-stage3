#!/usr/bin/env python
# -*- coding: utf-8 -*-

import json
import webbrowser, os
import time


# TODO: it is too ad hoc
def read_states_file():
    states = set()
    states_pairs = []
    with open('states.txt') as states_f:
        lines = states_f.readlines()
        current_state = 0
        for index, line in enumerate(lines):
            line = line.strip("\n")
            if "===" in line:
                continue

            if "State" in line:
                line = line.strip("\n")
                state_value = line[line.index(":")+2:]
                states.add(state_value)
                current_state = state_value

            if "==" in line:
                pre_state = line[line.index(" ") + 1:]
                states.add(pre_state)
                states_pairs.append((pre_state, current_state))

            if ">=" in line and "====" in lines[index+1]:
                pre_state = line[line.index(" ") + 1:]
                states.add(pre_state)
                states_pairs.append((pre_state, current_state))

            else:
                continue

    return sorted(states), states_pairs


def generate_data_from_states(states):
    data = []
    x_start = 100
    y_start = 200
    step = 300
    for index, state in enumerate(states):
        line_n = index // 3
        if line_n % 2 == 0:
            current_x = x_start + (index % 3) * step
        else:
            current_x = x_start + abs(index % 3 - 2) * step

        current_y = y_start + line_n * step
        current_node = dict()
        current_node["name"] = state
        current_node["x"] = current_x
        current_node["y"] = current_y
        current_node["label"] = {"fontSize": 30}
        data.append(current_node)

    return data


def generate_links(state_pairs):
    links = []
    for pair in state_pairs:
        current_link = dict()
        current_link['source'] = pair[0]
        current_link['target'] = pair[1]
        current_link['lineStyle'] = {
            "normal": {
                "curveness": 0.2
            }
        }
        links.append(current_link)

    return links


def generate_json_config():
    states, state_pairs = read_states_file()

    # read a json file
    with open('option_config.json') as f:
        json_data = json.load(f)

    data = generate_data_from_states(states)
    json_data["series"][0]["data"] = data

    # generate links
    links = generate_links(state_pairs)
    json_data["series"][0]["links"] = links

    with open('data.json', 'w') as outfile:
        json.dump(json_data, outfile)

    with open('data.json') as infile:
        line = infile.read()
        line = "var option = " + line

    with open('data.js', 'w') as outfile:
        outfile.write(line)


def main():

    # TODO: read states
    print("reading raw state data...........")
    generate_json_config()

    #
    # # generate options
    print("generate state machine graph......")
    path = os.path.dirname(os.path.abspath(__file__))
    filename = path + "/index_test.html"
    time.sleep(0.1)

    # open a web browser and load the state machine graph
    print("load state machine graph......")
    time.sleep(0.1)
    webbrowser.open(filename)


if __name__ == '__main__':
    main()
