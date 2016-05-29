$( document ).ready(function() {
  if ($('body').attr('id').match(/popularities-history/)) {
    d3.json("history_data", function(appear) {
      var margin = {top: 20, right: 20, bottom: 30, left: 40},
      width = 1200 - margin.left - margin.right,
      height = 960 - margin.top - margin.bottom;

      var svg = d3.select("#vis").append("svg")
                  .attr("width", width + margin.left + margin.right)
                  .attr("height", height + margin.top + margin.bottom)
                  .append("g")
                  .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

      var dates = [
        "2010/4",
        "5",
        "6",
        "7",
        "8",
        "9",
        "10",
        "11",
        "12",
        "2011/1",
        "2",
        "3",
        "4",
        "5",
        "6",
        "7",
        "8",
        "9",
        "10",
        "11",
        "12",
        "2012/1",
        "2",
        "3",
        "4",
        "5",
        "6",
        "7",
        "8",
        "9",
        "10",
        "11",
        "12",
        "2013/1",
        "2",
        "3",
        "4",
        "5",
        "6",
        "7",
        "8",
        "9",
        "10",
        "11",
        "12",
        "2014/1",
        "2",
        "3",
        "4",
        "5",
        "6",
        "7",
        "8",
        "9",
        "10",
        "11",
        "12",
        "2015/1",
        "2",
        "3",
        "4",
        "5",
        "6",
        "7",
        "8",
        "9",
        "10",
        "11",
        "12",
        "2016/1",
        "2",
        "3"
      ]

      var xScale = d3.scale.linear()
                      .domain([0,71])
                      .range([0,width]);

      var yScale = d3.scale.linear()
                      .domain([0,105])
                      .range([height,0]);

      var colorCategoryScale = d3.scale.category10();

      var xAxis = d3.svg.axis()
                      .scale(xScale)
                      .orient("bottom")
                      .tickSize(6, -height)
                      .tickFormat(function(d){ return dates[d];})
                      .tickValues([0, 3, 6, 9, 12, 15, 18, 21, 24, 27, 30, 33, 36, 39, 42, 45, 48, 51, 54, 57, 60, 63, 66, 69, 71]);

      var yAxis = d3.svg.axis()
                      .ticks(5)
                      .scale(yScale)
                      .orient("left")
                      .tickSize(6, -width);

      // lineの設定。
      var line = d3.svg.line()
          .x(function(d) { return xScale(d["i"]); })
          .y(function(d) { return yScale(d["appear"]); })
          .interpolate("cardinal"); // 線の形を決める。

      svg.selectAll("circle")
          .data(appear)
          .enter()
           .append("circle")
           .attr("r",5)
           .attr("fill", function(d){ return colorCategoryScale(d["increasing"]); })
           .attr("cx", function(d){ return xScale(d['i']); })
           .attr("cy", function(d){ return yScale(d["appear"]); });

      // line表示。
      svg.append("path")
           .datum(appear)
           .attr("class", "line")
           .attr("d", line); // 上で作ったlineを入れて、ラインpathを作る。

      svg.append("g")
          .attr("class", "y axis")
          .call(yAxis)
          .append("text")
            .attr("y", -10)
            .attr("x",10)
            .style("text-anchor", "end")
            .text("appear(TV出演数(回))");

      svg.append("g")
          .attr("class", "x axis")
          .attr("transform", "translate(0," + height + ")")
          .call(xAxis);
    });
  }
});
