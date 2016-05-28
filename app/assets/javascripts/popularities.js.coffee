$ ->
  if $('body').attr('id').match(/popularities-index/)
    d3.json "popularities/appear_ranking_data", (data) ->
      console.log(data)
      max = data[0].appear_count
      x = d3.scale.linear()
          .domain([0, max])
          .range([0, max * 10])

      d3.select(".appear_ranking_chart")
        .selectAll("div")
          .data(data)
        .enter().append("div")
          .style("width", (d) -> x(d.appear_count) + "px")
          .text((d) -> d.name + "(#{d.company}) " + d.appear_count + "回")
