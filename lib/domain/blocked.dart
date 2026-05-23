class Blocked {
  final List<BlockedRessource> blockedRessources;

  const Blocked({
    required this.blockedRessources
  });
}

sealed class BlockedRessource{
  const BlockedRessource();

  String get id;
  String get label;
}

class BlockedWebsite extends BlockedRessource{
  @override
  final String id;

  final String domain;

  const BlockedWebsite({
    required this.id,
    required this.domain
  });

  @override
  String get label => domain;
}

class BlockedApp extends BlockedRessource{
  @override
  final String id;

  final String packageName;

  final String appName;

  const BlockedApp({
    required this.id,
    required this.packageName,
    required this.appName
  });

  @override
  String get label => appName;
}