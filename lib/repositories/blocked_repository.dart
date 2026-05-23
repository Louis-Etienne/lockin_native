import 'package:lockin_native_2/domain/blocked.dart';

abstract class BlockedRepository {
  Future<Blocked> add(BlockedRessource newBlockedRessource);
  Future<Blocked> remove(BlockedRessource blockedRessource);
  Future<Blocked> get();
}

class MockBlockedRepository extends BlockedRepository{
  final List<BlockedRessource> ressources = [
    BlockedWebsite(
      id: "id1",
      domain: "https://facebook.com",
    ),
    BlockedApp(
      id: "id2",
      packageName: "Youtube_android",
      appName: "Youtube",
    ),
  ];

  @override
  Future<Blocked> add(BlockedRessource newBlockedRessource) async {
    ressources.add(newBlockedRessource);

    await Future.delayed(Duration(milliseconds: 1000));

    return Blocked(blockedRessources: ressources);
  }
    
  @override
  Future<Blocked> remove(BlockedRessource blockedRessource) async {
    ressources.removeWhere((r)=> r.id == blockedRessource.id);

    await Future.delayed(Duration(milliseconds: 1000));

    return Blocked(blockedRessources: ressources);
  }
  
  @override
  Future<Blocked> get() async {
    await Future.delayed(Duration(milliseconds: 1000));

    return Blocked(blockedRessources: ressources);
  }

}