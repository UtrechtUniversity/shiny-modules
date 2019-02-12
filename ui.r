ui <- dashboardPage(skin = "black",
                    dashboardHeader(title = "Modules Example Shiny",titleWidth = 350), 
                    
                    # sidebar 
                    dashboardSidebar(width = 350,
                                     sidebarMenu(#menuItem("", tabName = "home", icon = icon("home")),
                                       menuItem(HTML("<i class='fa fa-home'></i>"), tabName = "home"),
                                       menuItem("areas", tabName = "tab1")
                                     )
                    ),
                    # dashboardbody code 
                    dashboardBody(
                      tabItems(
                        tabItem(tabName = "tab1", 
                                fluidRow( 
                                  box( width = 12, align = "left",
                                       plotAreaUI("areaPlot")
                                  ) # end box
                                ) # end fluidrow
                        )
                      )
                      
                    )
)