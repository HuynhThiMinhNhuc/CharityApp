import 'package:charityapp/views/Component/post_overview.dart';
import 'package:charityapp/views/HomeView/profile_overview.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  final List<PostOverview> listPosts;

  ProfilePage({this.listPosts = const []});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
          children: [
            ProfileOverView(
                "Vũ Ngọc Thạch",
                DateTime.now(),
                "Bạn là giọt nước trong biển lớn, gột rửa tâm hồn của nhân loại. Bạn là ngọn lửa trong đồng vắng, bừng cháy lên hy vọng tốt đẹp. ...",
                [25, 50, 100]),
            Container(
              child: ListView.separated(
                  itemBuilder: (_, index) {
                    return PostOverview(
                        "Vũ Ngọc Thạch",
                        "Long An, Viet Nam",
                        "Hoạt động vận chuyển nhà cho người già neo đơn Quận 1",
                        "Tháng 11 chúng tôi sẽ tỗ chức hoạt động vận chuyển nhà cho cụ Nguyễn Văn A tại quận 1, tp Hồ Chí Minh",
                        ["Trẻ mồ côi", "Môi trường"],
                        "asset/imagesample/post1.jpg");
                  },
                  separatorBuilder: (_, index) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          height: 1,
                          color: Colors.black,
                        ),
                      ],
                    );
                  },
                  itemCount: 3,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,),
            ),
          ],
      ),
    );
  }
}
