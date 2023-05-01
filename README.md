# CryptoApp

# Main Page

Main page is Crypto list where user can see all crypto  with its prices. 
Details page is to see last days price changes, its horizontal scrollable
The Architecture has several files:

View - Swifui view which also using other views and view Modifiers (Component files)
Store - its observedObject to update view easily
Presenter - presenter waits interactor response and than clean model to update view
Interactor - interactor is using workers and get called by view and interactor use presenter to give data response
Worker - this is very alike to displays and gateways which are used for api calls
configurator - for dependency injection


Also theres local package NetworkLayer and there is written Requests, Fetch requests and response.

Main Stack: SwiftUI, Combine, New concurency like async await, VIPER (+ State for Viewmodek), Unit testing, Package Manager.
