import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yolustunde_mobile/models/company_model.dart';
import 'package:yolustunde_mobile/models/company_type_model.dart';
import 'package:yolustunde_mobile/models/dio/dio_response.dart';
import 'package:yolustunde_mobile/providers/user_provider.dart';
import 'package:yolustunde_mobile/screens/CompanyDetail/company_detail.dart';
import 'package:yolustunde_mobile/services/dio_service.dart';
import 'package:yolustunde_mobile/services/image_service.dart';
import 'package:yolustunde_mobile/theme/colors.dart';
import 'package:yolustunde_mobile/widgets/company_widgets/favorite_company_widget.dart';
import 'package:yolustunde_mobile/widgets/my_app_bar.dart';
import 'package:yolustunde_mobile/widgets/my_button.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  void initState() {
    super.initState();
    getCompanyTypes();
    getFavorites();
  }

  void getFavorites() {
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.getFavorites();
  }

  List<CompanyTypeModel> companyTypes = [];
  CompanyTypeModel? selectedCompanyType;

  Future<void> getCompanyTypes() async {
    DioResponse dioResponse = await DioService().request('parameters/companytypes');
    if (dioResponse.isSuccessful) {
      companyTypes = dioResponse.data['data'].map<CompanyTypeModel>((e) => CompanyTypeModel.fromMap(e)).toList();
      selectedCompanyType = companyTypes.first;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    List<CompanyModel> favoriteCompanies = selectedCompanyType != null
        ? userProvider.favoriteCompanies.where((element) => element.type.toLowerCase() == selectedCompanyType!.title.toLowerCase()).toList()
        : [];
    return Scaffold(
      appBar: buildAppBar(title: 'Favori İşletmeler', showBackButton: false),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(
                height: 50,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: companyTypes.length,
                  separatorBuilder: (context, index) => SizedBox(width: 10),
                  itemBuilder: (context, index) {
                    CompanyTypeModel companyType = companyTypes[index];
                    return GestureDetector(
                      onTap: () {
                        selectedCompanyType = companyType;
                        setState(() {});
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: selectedCompanyType == companyType ? MyColors.yellow : Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: MyColors.greyLight2),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        child: Center(child: Text(companyType.title)),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.separated(
                  itemCount: favoriteCompanies.length,
                  separatorBuilder: (context, index) => SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    CompanyModel company = favoriteCompanies[index];
                    return FavoriteCompanyWidget(company: company);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
