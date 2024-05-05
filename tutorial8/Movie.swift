import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

public struct Movie : Codable
{
    @DocumentID var documentID:String?
    var title:String
    var year:Int32
    var duration:Float
}
