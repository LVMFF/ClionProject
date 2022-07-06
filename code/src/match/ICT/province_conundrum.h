//
// Created by h00679994 on 2022/7/4.
//

#ifndef CLIONPROJECT_PROVINCE_CONUNDRUM_H
#define CLIONPROJECT_PROVINCE_CONUNDRUM_H

#include <iostream>
#include <vector>
#include <map>
using namespace std;

struct Point
{
    int32_t x;
    int32_t y;
    int32_t  province_index{-1};
};

struct Edge
{
    uint32_t send;
    uint32_t recv;
};

struct Flow
{
    uint32_t f;
    vector<uint32_t> path;
};

using SubGraph = vector<uint32_t>;
uint32_t v = 4, e = 6, t = 4, r = 3;
vector<Point> g_points = {
        {0, 0},
        {1, 0},
        {1, 1},
        {0, 1},
};
vector<Edge> g_edges = {
        {0, 1},
        {1, 2},
        {2, 3},
        {3, 0},
        {0, 2},
        {1, 3},
};
vector<Flow> g_flows = {
        {1, {0, 1, 2}},
        {10, {0, 3, 2}},
        {100, {3, 1}},
        {1000, {0, 2}},
};

#endif //CLIONPROJECT_PROVINCE_CONUNDRUM_H
