from django.contrib.auth import get_user_model
from django.contrib.auth.hashers import check_password


class MyAuthBackend(object):
    @staticmethod
    def authenticate(email=None, phone=None, password=None, **kwargs):
        print('------------back auth---------------')
        print(email)
        print(phone)
        my_user_model = get_user_model()
        try:
            if email:
                print('------it\'s email-----')
                # Try to fetch the user by searching the username or email field
                user = my_user_model.objects.get(email=email)
                if not user:
                    return None
                try:
                    if check_password(password, user.password):
                        user.temporary_password = False
                        user.alternative_password = None
                        user.save()
                        return user
                    elif check_password(password, user.alternative_password):
                        return user
                except Exception as e:
                    print(e)
            elif phone:
                print('------it\'s phone----------')
                # Try to fetch the user by searching the username or email field
                user = my_user_model.objects.get(phone=phone)
                if not user:
                    return None
                if check_password(password, user.password):
                    user.temporary_password = False
                    user.alternative_password = None
                    user.save()
                    return user
                elif check_password(password, user.alternative_password):
                    return user
        except my_user_model.DoesNotExist:
            # Run the default password hasher once to reduce the timing
            # difference between an existing and a non-existing user (#20760).
            return None
