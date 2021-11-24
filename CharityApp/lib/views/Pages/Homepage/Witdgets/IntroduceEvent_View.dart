import 'package:charityapp/Constant/user_json.dart';
import 'package:charityapp/global_variable/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class introduceeventview extends StatefulWidget {
  const introduceeventview({ Key? key }) : super(key: key);

  @override
  _introduceeventviewState createState() => _introduceeventviewState();
}

class _introduceeventviewState extends State<introduceeventview> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Thông tin chung",
          style: TextStyle(
                    fontFamily: 'Roboto_Regular',
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: textcolor
          ),
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              Icon(Icons.people_outline),
              SizedBox(width: 5,),
              Text(users[0]['name'] + " đã tạo sự kiện này")
            ],
          ),
          Row(
            children: [
              Icon(Icons.add_task_outlined),
              SizedBox(width: 5,),
              Text("160 người đã tham gia sự kiện này")
            ],
          ),
          Row(
            children: [
              Icon(Icons.lock_clock_outlined),
              SizedBox(width: 5,),
              Text("Sự kiện sẽ diễn ra vào ngày 14/05/2021")
            ],
          ),
          SizedBox(height: 10,),
          OutlinedButton(
                      onPressed: null,
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0))),
                      ),
                      child: Text('Trẻ em',
                      style: TextStyle(
                        fontFamily: 'Roboto_Regular',
                        fontSize: 12,
                      ),),
                    ),
          SizedBox(height: 10,),
          Text(
            "Câu chuyện", 
            style: 
              TextStyle(
                        fontFamily: 'Roboto_Regular',
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                      ),),
          Text("Chùa Quang Châu là một ngôi chùa nhỏ đã được gần 23 năm tuổi thuộc xã Quang Châu, huyện Hòa Vang, TP Đà Nẵng. Vốn được biết đến là nơi chăm sóc và dạy dỗ nhiều trẻ em bị cha mẹ bỏ rơi từ lúc mới chào đời. Mái ấm tình thương này do sư cô Minh Tịnh tạo ra. Ở chùa, các phòng ngủ được chia trong các gian sau đại điện chính thờ tự, khu ăn uống, khu nghỉ ngơi, phòng vui chơi, học tập, các căn phòng ngăn nắp, ấm cúng và gọn gàng. Hơn 100 đứa trẻ mồ côi tại đây đều phải tự ăn tự uống tự tắm rửa mà không cần có người giúp đỡ. Khó khăn và vất vả càng tăng cao khi đến mùa đau ốm của các em. Những tình nguyên viên gắn bó nơi đây hơn 10 năm, mỗi người phải chăm sóc từ 10 đến 16 em cùng một lúc. Hiểu được những khó khăn, thiếu thốn và cả sự thiệt thòi của các em tại chùa Quang Châu, các bạn sinh viện VNUK đã quyết tâm tổ chức chương trình tình nguyện với mong muốn không chỉ đem lại sự ấm áp cho các em, mà còn được trải nghiệm những khó khăn để có thể trưởng thành và biết yêu quý những gì mà chúng mình đang có. Để chương trình tình nguyện được diễn ra thành công tốt đẹp, các bạn sinh viên VNUK đã tổ chức rất nhiều hoạt động gây quỹ như kêu gọi quyên góp, bán vật phẩm gây quỹ, và hoạt động tiêu biểu nhất phải kể đến chính là đêm nhạc gây quỹ tình nguyện. Với tên gọi Live music, đêm nhạc gây quỹ từ thiện của Liên Chi đoàn VNUK chính là đêm nhạc của những tấm lòng thiện nguyện. Đêm nhạc được tổ chức và hỗ trợ hoàn toàn bởi các nhạc công và ca sĩ xịn sò đến từ các band nhạc sinh viên VNUK. Chính tấm lòng cảm thông, thiện nguyện của các bạn sinh viên đã lan toả được thông điệp tốt đẹp của chương trình và nhận được sự ủng hộ nhiệt tình của các bạn trẻ trong đêm nhạc. Ngoài ra, VNUK cũng gửi lời cảm ơn chân thành đến nhà tài trợ Quán Posiki Dorm - 04 Lê Đình Dương đã tài trợ địa điểm tổ chức đêm nhạc cũng như một phần kinh phí quà tặng để chương trình trở nên ấm áp hơn, ý nghĩa hơn.Tại buổi tình nguyện, VNUK đã trao tặng 20 cặp cho trẻ, 50 kg gạo, 6 thùng sữa, 40 cây bút bi, khoảng 30 cuốn sách thiếu nhi, 2 triệu đồng tiền mặt và nhiều quần áo, vật phẩm khác Cuộc sống thật đẹp khi mỗi chúng ta đều đóng góp những việc làm nhỏ nhưng có ích và ý nghĩa phải không nào? Chương trình tình nguyện Thắp sáng nụ cười trẻ thơ đã khép lại, song đã để lại vô vàn những cảm xúc khó tả cho những người tổ chức như chúng tôi. Cảm thông - chính là 1 trong 3 giá trị cốt lõi mà thầy và trò VNUK hướng đến. Chính vì thế, chúng tôi tin rằng, sau “Thắp sáng nụ cười trẻ thơ 2019”, sẽ còn đó thật nhiều những chương trình ý nghĩa như thế được diễn ra, góp phần chia sẻ với cộng đồng. VNUK thật hy vọng sẽ lại tiếp tục nhận được sự ủng hộ của mọi người trong những dự án ý nghĩa sắp tới nữa nhé"
          ,
          style: TextStyle(
                        fontFamily: 'Roboto_Regular',
                        fontSize: 13,
                      ),)

        ],

        
      ),
    );
  }
}