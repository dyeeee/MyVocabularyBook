import SwiftUI

struct SearchTestView: View {
    @State var text:String?
    var body: some View {
        GroceryList(groceries: [
            Grocery(name:"Apple"),
            Grocery(name:"Pear"),
            Grocery(name:"Plum"),
            Grocery(name:"Orangle"),
            Grocery(name:"Pineapple"),


        ])
    }
}

struct SearchTestView_Previews: PreviewProvider {
    static var previews: some View {
        SearchTestView()
    }
}

struct Grocery: Identifiable{
    var id = UUID()
    var name = ""
}

struct GroceryList: View {

    var groceries: [Grocery]
    @State  var searchTerm: String?
     var scopes: [String]? = ["水果", "蔬菜"]
    @State  var selectedScope: Int = 0

    var predicate: (Grocery) -> Bool {
        if let searchTerm = searchTerm {
            return { grocery in
                grocery.name.localizedCaseInsensitiveContains(searchTerm)
            }
        } else {
            return { _ in true }
        }
    }

    var body: some View {
        NavigationView {
            List(groceries.filter(predicate)) { grocery in
                //Text(grocery.name)
            }
            .navigationBarTitle("水果")
            .navigationSearchBar(
                searchTerm: $searchTerm,
                scopes: scopes,
                selectedScope: $selectedScope
            )
        }
    }
}


struct NavigationSearchBarHosting: UIViewControllerRepresentable {

    @Binding var searchTerm: String?
    var scopes: [String]?
    @Binding var selectedScope: Int

    func makeUIViewController(context: Context) -> UIViewController {
        return UIViewController()
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        uiViewController.parent?.navigationItem.searchController = context.coordinator.searchController
        uiViewController.parent?.navigationItem.hidesSearchBarWhenScrolling = false

        context.coordinator.searchController.searchBar.text = searchTerm
        context.coordinator.searchController.searchBar.scopeButtonTitles = scopes
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UISearchBarDelegate, UISearchResultsUpdating {

        var parent: NavigationSearchBarHosting
        let searchController: UISearchController

        init(_ navigationSearchBarHosting: NavigationSearchBarHosting) {
            self.parent = navigationSearchBarHosting
            self.searchController = UISearchController()
            super.init()
            setupSearchController()
        }

        private func setupSearchController() {
            searchController.searchResultsUpdater = self
            searchController.obscuresBackgroundDuringPresentation = false
            searchController.searchBar.showsScopeBar = true
            searchController.searchBar.delegate = self
        }

        // UISearchResultsUpdating
        func updateSearchResults(for searchController: UISearchController) {
            parent.searchTerm = searchController.searchBar.text
        }

        // UISearchBarDelegate
        func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
            parent.selectedScope = selectedScope
        }
    }
}

struct NavigationSearchBarModifier: ViewModifier {

    @Binding var searchTerm: String?
    var scopes: [String]?
    @Binding var selectedScope: Int

    func body(content: Content) -> some View {
        content.background(
            NavigationSearchBarHosting(
                searchTerm: $searchTerm,
                scopes: scopes,
                selectedScope: $selectedScope
            )
        )
    }
}

public extension View {

    func navigationSearchBar(
        searchTerm: Binding<String?>
    ) -> some View {
        self.modifier(
            NavigationSearchBarModifier(
                searchTerm: searchTerm,
                scopes: nil,
                selectedScope: .constant(0)
            )
        )
    }

    func navigationSearchBar(
        searchTerm: Binding<String?>,
        scopes: [String]?,
        selectedScope: Binding<Int>
    ) -> some View {
        self.modifier(
            NavigationSearchBarModifier(
                searchTerm: searchTerm,
                scopes: scopes,
                selectedScope: selectedScope
            )
        )
    }
}
