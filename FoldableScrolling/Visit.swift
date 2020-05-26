// Kevin Li - 6:00 PM - 5/25/20

import SwiftUI

struct Visit {

    let locationName: String
    let tagColor: Color
    let arrivalDate: Date
    let departureDate: Date
    let notes: String
    
    var duration: String {
        arrivalDate.timeOnlyWithPadding + " ➝ " + departureDate.timeOnlyWithPadding
    }

}

extension Visit: Identifiable {

    var id: Int {
        locationName.hashValue
    }

}

extension Visit {

    static let mock = Visit(locationName: "Apple Inc", tagColor: .blue, arrivalDate: Date(), departureDate: Date().addingTimeInterval(180), notes: notesText)

    static let mocks = [
        Visit(locationName: "Apple Inc", tagColor: .blue, arrivalDate: Date(), departureDate: Date().addingTimeInterval(1800), notes: notesText),
        Visit(locationName: "Buckeye Stadium", tagColor: .green, arrivalDate: Date().addingTimeInterval(100), departureDate: Date().addingTimeInterval(1000), notes: notesText),
        Visit(locationName: "Jenni's Ice Cream", tagColor: .green, arrivalDate: Date().addingTimeInterval(200), departureDate: Date().addingTimeInterval(5000), notes: notesText),
        Visit(locationName: "Eiffel Tower", tagColor: .gray, arrivalDate: Date().addingTimeInterval(40), departureDate: Date().addingTimeInterval(3100), notes: notesText),
        Visit(locationName: "Stonehenge", tagColor: .green, arrivalDate: Date().addingTimeInterval(70), departureDate: Date().addingTimeInterval(3000), notes: notesText),
        Visit(locationName: "Porkfolio KBBQ", tagColor: .blue, arrivalDate: Date(), departureDate: Date().addingTimeInterval(430), notes: notesText),
        Visit(locationName: "Fork Over Pork", tagColor: .green, arrivalDate: Date(), departureDate: Date().addingTimeInterval(870), notes: notesText),
        Visit(locationName: "Tesla HeadQuarters", tagColor: .gray, arrivalDate: Date(), departureDate: Date().addingTimeInterval(954), notes: notesText),
        Visit(locationName: "Google HeadQuarters", tagColor: .gray, arrivalDate: Date(), departureDate: Date().addingTimeInterval(340), notes: notesText)
    ]

}

fileprivate let notesText = """
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Imperdiet proin fermentum leo vel orci porta non pulvinar. Eu volutpat odio facilisis mauris sit. Curabitur vitae nunc sed velit dignissim sodales ut eu sem. Mattis nunc sed blandit libero volutpat sed cras ornare. Arcu ac tortor dignissim convallis aenean et. Placerat vestibulum lectus mauris ultrices. Mauris cursus mattis molestie a iaculis at erat pellentesque. Enim nulla aliquet porttitor lacus luctus. Odio euismod lacinia at quis risus sed vulputate odio.

Purus in mollis nunc sed. Nulla aliquet porttitor lacus luctus accumsan tortor posuere ac. Enim sed faucibus turpis in eu mi. Ac tortor dignissim convallis aenean et tortor at. Praesent tristique magna sit amet purus gravida quis blandit. Nisi est sit amet facilisis magna etiam tempor orci. Odio pellentesque diam volutpat commodo sed egestas egestas fringilla phasellus. Id velit ut tortor pretium viverra suspendisse potenti. Ut faucibus pulvinar elementum integer enim. Lacus vel facilisis volutpat est velit egestas dui id ornare. Amet est placerat in egestas erat.

Adipiscing bibendum est ultricies integer. At imperdiet dui accumsan sit amet nulla. Lorem donec massa sapien faucibus. Libero volutpat sed cras ornare arcu dui vivamus arcu. Pellentesque sit amet porttitor eget. Ultrices neque ornare aenean euismod elementum nisi quis eleifend. Enim nulla aliquet porttitor lacus. Rhoncus est pellentesque elit ullamcorper. Pellentesque eu tincidunt tortor aliquam nulla facilisi cras fermentum odio. Pretium vulputate sapien nec sagittis aliquam malesuada bibendum arcu vitae. Eu lobortis elementum nibh tellus molestie nunc non blandit. Ornare arcu odio ut sem. Praesent elementum facilisis leo vel fringilla est ullamcorper eget nulla. Fermentum posuere urna nec tincidunt praesent.

Feugiat vivamus at augue eget arcu dictum varius duis at. Ultricies mi quis hendrerit dolor magna eget est lorem. In ante metus dictum at tempor commodo. Vitae congue eu consequat ac felis donec. Vitae elementum curabitur vitae nunc sed velit dignissim sodales ut. A pellentesque sit amet porttitor. Malesuada fames ac turpis egestas integer. Pulvinar sapien et ligula ullamcorper malesuada. Sed elementum tempus egestas sed sed risus pretium. Sapien eget mi proin sed. Diam sollicitudin tempor id eu nisl nunc. Suspendisse ultrices gravida dictum fusce ut placerat orci nulla pellentesque.

Eros donec ac odio tempor orci dapibus ultrices in iaculis. Egestas congue quisque egestas diam in arcu cursus euismod. Gravida in fermentum et sollicitudin ac. Donec ultrices tincidunt arcu non sodales. Pretium quam vulputate dignissim suspendisse in. Viverra tellus in hac habitasse. Enim diam vulputate ut pharetra sit. Eu feugiat pretium nibh ipsum consequat nisl vel. Morbi non arcu risus quis varius quam quisque id diam. Massa enim nec dui nunc mattis enim ut. Id donec ultrices tincidunt arcu non sodales neque. Ante in nibh mauris cursus.

Eget arcu dictum varius duis at. Vel pharetra vel turpis nunc eget lorem dolor. Posuere urna nec tincidunt praesent. Nec feugiat in fermentum posuere urna nec tincidunt praesent semper. Leo integer malesuada nunc vel. Nisi lacus sed viverra tellus in hac habitasse platea. Quisque egestas diam in arcu cursus euismod. Habitasse platea dictumst vestibulum rhoncus. Nunc sed velit dignissim sodales ut eu sem. Consectetur adipiscing elit ut aliquam purus sit amet luctus venenatis. In pellentesque massa placerat duis ultricies.

Dui id ornare arcu odio ut sem nulla pharetra. Tristique senectus et netus et malesuada fames ac turpis. Tellus integer feugiat scelerisque varius morbi enim nunc. Risus in hendrerit gravida rutrum quisque non tellus. Purus faucibus ornare suspendisse sed nisi lacus sed. Vitae ultricies leo integer malesuada nunc vel. Amet aliquam id diam maecenas ultricies mi eget mauris pharetra. Nec tincidunt praesent semper feugiat nibh sed pulvinar proin. Nunc sed id semper risus in hendrerit. Elementum nisi quis eleifend quam. Integer vitae justo eget magna fermentum. Sed id semper risus in. Leo duis ut diam quam nulla porttitor massa id. Feugiat nisl pretium fusce id velit. Nullam vehicula ipsum a arcu cursus vitae congue mauris rhoncus.

Fames ac turpis egestas sed tempus urna et pharetra. Ullamcorper a lacus vestibulum sed. Nulla facilisi etiam dignissim diam. A erat nam at lectus urna duis convallis. Donec pretium vulputate sapien nec sagittis aliquam malesuada. Scelerisque viverra mauris in aliquam sem fringilla ut morbi tincidunt. Mattis enim ut tellus elementum sagittis vitae et leo. Sed turpis tincidunt id aliquet risus feugiat in ante. Et tortor at risus viverra adipiscing at in tellus. Gravida rutrum quisque non tellus orci ac auctor. Ridiculus mus mauris vitae ultricies leo integer malesuada. Nulla pellentesque dignissim enim sit amet venenatis urna cursus eget. Amet consectetur adipiscing elit duis. Libero justo laoreet sit amet cursus sit amet. Ultricies lacus sed turpis tincidunt id aliquet risus feugiat. Sit amet cursus sit amet dictum.

Nunc sed velit dignissim sodales ut. Sit amet volutpat consequat mauris nunc. Viverra ipsum nunc aliquet bibendum enim facilisis gravida neque. Ultricies tristique nulla aliquet enim tortor at. Ullamcorper malesuada proin libero nunc consequat interdum varius sit. Amet consectetur adipiscing elit pellentesque habitant. Non blandit massa enim nec. Iaculis at erat pellentesque adipiscing commodo elit at imperdiet dui. Urna id volutpat lacus laoreet non. Etiam non quam lacus suspendisse faucibus interdum posuere. Et malesuada fames ac turpis egestas maecenas. Placerat in egestas erat imperdiet sed euismod nisi. Posuere sollicitudin aliquam ultrices sagittis orci a scelerisque purus semper. Aliquam sem et tortor consequat. Arcu non odio euismod lacinia at quis. Praesent semper feugiat nibh sed pulvinar proin gravida hendrerit. Netus et malesuada fames ac.

Nisl vel pretium lectus quam id. Quis blandit turpis cursus in hac habitasse. Sed nisi lacus sed viverra tellus in hac habitasse. Eu scelerisque felis imperdiet proin. Ac ut consequat semper viverra nam libero. Felis donec et odio pellentesque. Eu ultrices vitae auctor eu augue ut. Ac placerat vestibulum lectus mauris ultrices eros in cursus. At auctor urna nunc id cursus metus aliquam eleifend. Vel elit scelerisque mauris pellentesque pulvinar pellentesque. Morbi quis commodo odio aenean sed adipiscing diam donec. Aliquet risus feugiat in ante metus dictum at tempor commodo. Posuere urna nec tincidunt praesent semper feugiat. Mi in nulla posuere sollicitudin. Aliquam etiam erat velit scelerisque in dictum. Elit duis tristique sollicitudin nibh sit amet commodo nulla facilisi. Lectus mauris ultrices eros in cursus turpis massa tincidunt. Purus sit amet volutpat consequat.
"""
