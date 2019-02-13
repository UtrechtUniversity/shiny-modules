ui <- dashboardPage(skin = "black",
                    dashboardHeader(title = "Modules Example Shiny",titleWidth = 350), 
                    
                    # sidebar 
                    dashboardSidebar(width = 350,
                                     # Define the sidebar menu
                                     sidebarMenu(
                                       menuItem(HTML("<i class='fa fa-home'></i>"), tabName = "home"),
                                       menuItem("Plots", tabName = "tab1")
                                     )
                    ),
                    # dashboardbody code 
                    dashboardBody(
                      tabItems(
                        tabItem(tabName = "home"),
                        
                        tabItem(tabName = "tab1", 
                                sidebarLayout(
                                  sidebarPanel(
                                    checkboxInput("switchArea", "Area Plot"),
                                    checkboxInput("switchChains", "Chains Plot"),
                                    checkboxInput("switchScatter", "Scatter Plot")
                                  ),
                                  mainPanel(
                                    tabsetPanel(id = "tabs"
                                                )
                                  )
                                )
                        )
                      ) # end tabItems
                      
                    )
)