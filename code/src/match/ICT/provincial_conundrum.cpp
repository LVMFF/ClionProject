//
// Created by h00679994 on 2022/7/4.
//

#include "province_conundrum.h"

// 按照成本排序

uint32_t GetSubGraphNum()
{
}

vector<SubGraph> SolveCase(uint32_t V, uint32_t E, uint32_t T, uint32_t R, const vector<Point>& points,
                           const vector<Edge>& edges, const vector<Flow>& flows)
{
    vector<SubGraph> subGraphs;

    // 子图个数
    uint32_t subGraphNum = GetSubGraphNum();
    subGraphs.emplace_back(SubGraph{subGraphNum});

    //
    return subGraphs;
}