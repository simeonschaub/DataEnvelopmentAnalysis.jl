using Documenter, DataEnvelopmentAnalysis

makedocs(sitename = "DataEnvelopmentAnalysis",
        authors = "Javier Barbero and José Luis Zofío.",
        pages = [
        "Home" => "index.md",
        "Technical Efficiency Models" => Any[
                "Radial Models" => "technical/radial.md",
                "Directional Distance Function Models" => "technical/directional.md",
                "Additive Models" => "technical/additive.md",
                "Generalized Distance Function Models" => "technical/generalizeddf.md",
                "Common functions for technical models" => "technical/commontechnical.md"
                ],
        "Economic Efficiency Models" => Any[
                "Cost Models" => "economic/cost.md",
                "Revenue Models" => "economic/revenue.md",
                "Profit Models" => "economic/profit.md",
                "Profitability Models" => "economic/profitability.md",
                "Common functions for economic models" => "economic/commoneconomic.md"
                ],
        "Productivity Change Models" => Any[
                "Malmquist Index" => "productivity/malmquist.md"
                "Common functions for productivity change models" => "productivity/commonproductivity.md"
                ],
        "Bibliography" => "bibliography.md"
        ],
        format = Documenter.HTML(prettyurls = get(ENV, "CI", nothing) == "true")
)

deploydocs(
    repo = "github.com/javierbarbero/DataEnvelopmentAnalysis.jl.git",
)
