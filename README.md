sbog/pw_policy
==============

Role to easily apply security policies to linux system user passwords

#### Requirements

Ansible 2.4

#### Role Variables

Role variables can be placed to a dictionary named `pwsec_group` for group
vars and `pwsec_host` for host vars. Host vars will override group ones. There
is an example for group vars:

```yaml
pw_group:
```

You can see all vars in `default/main.yml` vars file.

#### Dependencies

None

#### Example Playbook

```yaml
- name: Ensure password security policies
  hosts: all
  remote_user: root

  roles:
    - pw_policy
```

#### License

Apache 2.0

#### Author Information

Stanislaw Bogatkin (https://sbog.ru)
