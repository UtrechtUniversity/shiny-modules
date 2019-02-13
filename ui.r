ui <- dashboardPage(skin = "black",
                    dashboardHeader(title = "Modules Example Shiny",titleWidth = 350), 
                    
                    # sidebar 
                    dashboardSidebar(width = 350,
                                     # Define the sidebar menu
                                     sidebarMenu(
                                       menuItem(HTML("<i class='fa fa-home'></i>"), tabName = "home"),
                                       menuItem("areas", tabName = "tab1"),
                                       menuItem("chains", tabName = "tab2"),
                                       menuItem("scatter", tabName = "tab3")
                                     )
                    ),
                    # dashboardbody code 
                    dashboardBody(
                      tabItems(
                        tabItem(tabName = "home"),
                        
                        tabItem(tabName = "tab1", 
                                fluidRow( 
                                  box( width = 12, align = "left",
                                       # Call UI part of the module PlotArea.
                                       # It has been given the name areaPlot.
                                       # Explicitly call stanfit object
                                       plotAreaUI("areaPlot", stanFit = fit)
                                  ) # end box
                                ) # end fluidrow
                        ),
                        
                        tabItem(tabName = "tab2", 
                                fluidRow( 
                                  box( width = 12, align = "left",
                                       checkboxInput("chainsPlot_eval", "Get Trace Plots", value = FALSE),
                                       plotChainsUI("chainsPlot", stanFit = fit)
                                  ) # end box
                                ) # end fluidrow
                        ),
                        
                        tabItem(tabName = "tab3", 
                                fluidRow( 
                                  box( width = 12, align = "left",
                                       checkboxInput("scatterPlot_eval", "Get Scatter Plots", value = FALSE),
                                       plotScatterUI("scatterPlot", stanFit = fit)
                                  ) # end box
                                ) # end fluidrow
                        )
                        
                      ) # end tabItems
                      
                    )
)