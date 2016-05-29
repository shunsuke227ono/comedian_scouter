$( document ).ready(function() {
  if ($('body').attr('id').match(/popularities-history/)) {
    d3.json("history_data", function(appear) {
      var margin = {top: 20, right: 20, bottom: 30, left: 40},
      width = 960 - margin.left - margin.right,
      height = 960 - margin.top - margin.bottom;

      var svg = d3.select("#vis").append("svg")
                  .attr("width", width + margin.left + margin.right)
                  .attr("height", height + margin.top + margin.bottom)
                  .append("g")
                  .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

      var dates = [
        "2010年-04月",
        "2010年-05月",
        "2010年-06月",
        "2010年-07月",
        "2010年-08月",
        "2010年-09月",
        "2010年-10月",
        "2010年-11月",
        "2010年-12月",
        "2011年-01月",
        "2011年-02月",
        "2011年-03月",
        "2011年-04月",
        "2011年-05月",
        "2011年-06月",
        "2011年-07月",
        "2011年-08月",
        "2011年-09月",
        "2011年-10月",
        "2011年-11月",
        "2011年-12月",
        "2012年-01月",
        "2012年-02月",
        "2012年-03月",
        "2012年-04月",
        "2012年-05月",
        "2012年-06月",
        "2012年-07月",
        "2012年-08月",
        "2012年-09月",
        "2012年-10月",
        "2012年-11月",
        "2012年-12月",
        "2013年-01月",
        "2013年-02月",
        "2013年-03月",
        "2013年-04月",
        "2013年-05月",
        "2013年-06月",
        "2013年-07月",
        "2013年-08月",
        "2013年-09月",
        "2013年-10月",
        "2013年-11月",
        "2013年-12月",
        "2014年-01月",
        "2014年-02月",
        "2014年-03月",
        "2014年-04月",
        "2014年-05月",
        "2014年-06月",
        "2014年-07月",
        "2014年-08月",
        "2014年-09月",
        "2014年-10月",
        "2014年-11月",
        "2014年-12月",
        "2015年-01月",
        "2015年-02月",
        "2015年-03月",
        "2015年-04月",
        "2015年-05月",
        "2015年-06月",
        "2015年-07月",
        "2015年-08月",
        "2015年-09月",
        "2015年-10月",
        "2015年-11月",
        "2015年-12月",
        "2016年-01月",
        "2016年-02月",
        "2016年-03月"]

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
                      .tickFormat(function(d){ return dates[d];});

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
