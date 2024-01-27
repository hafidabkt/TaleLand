import 'package:project/utils/class/profileClass.dart';
import 'package:project/utils/constant.dart';
import 'package:project/backend/getProfile.dart';
import 'package:project/utils/global.dart';

Future<List<Profile>> getFollowees() async {
  Profile profile;
  List<Profile> profiles = [];
  for (var id in user!.followeesList) {
    final response =
        await supabase.from('profiles').select('*').eq('id', id).single();
    profile = await getProfile(response['id']);
    profiles.add(profile);
  }
  return profiles;
}

Future<void> dropFollowee(int id, int index) async {
  user!.followeesList.removeAt(index);
  final response = await supabase
      .from('followings')
      .delete()
      .eq('follower_id', user!.id)
      .eq('followee_id', id);

  // You might want to check the response for success or handle errors here
  if (response.error != null) {
    print('Error deleting followee: ${response.error!.message}');
    // Handle the error appropriately
  } else {
    print('Followee deleted successfully');
  }
}

Future<void> dropFollower(int id, int index) async {
  user!.followersList.removeAt(index);
  final response = await supabase
      .from('followings')
      .delete()
      .eq('followee_id', user!.id)
      .eq('follower_id', id);

  // You might want to check the response for success or handle errors here
  if (response.error != null) {
    print('Error deleting followee: ${response.error!.message}');
    // Handle the error appropriately
  } else {
    print('Followee deleted successfully');
  }
}

Future<List<Profile>> getFollowers() async {
  Profile profile;
  List<Profile> profiles = [];
  for (var id in user!.followersList) {
    final response =
        await supabase.from('profiles').select('*').eq('id', id).single();
    profile = await getProfile(response['id']);
    profiles.add(profile);
  }
  return profiles;
}