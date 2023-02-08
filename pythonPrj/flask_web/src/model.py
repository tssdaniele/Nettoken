from typing import Optional, List


class Credential:
    id: str
    note: str
    group_id: str
    name: str
    username: str
    email: str
    password: str
    logo: str
    dashboard_space_id: None
    phone: Optional[str]
    public_key: Optional[str]
    secret_key: Optional[str]
    shared: Optional[bool]

    def __init__(self, id: str, note: str, group_id: str, name: str, username: str, email: str, password: str, logo: str, dashboard_space_id: None, phone: Optional[str], public_key: Optional[str], secret_key: Optional[str], shared: Optional[bool]) -> None:
        self.id = id
        self.note = note
        self.group_id = group_id
        self.name = name
        self.username = username
        self.email = email
        self.password = password
        self.logo = logo
        self.dashboard_space_id = dashboard_space_id
        self.phone = phone
        self.public_key = public_key
        self.secret_key = secret_key
        self.shared = shared


class Group:
    id: str
    source: str
    name: str
    credentials: List[Credential]

    def __init__(self, id: str, source: str, name: str, credentials: List[Credential]) -> None:
        self.id = id
        self.source = source
        self.name = name
        self.credentials = credentials


class Profile:
    id: str
    phone: str
    app_id: str
    verified: bool
    active: bool
    groups: List[Group]

    def __init__(self, id: str, phone: str, app_id: str, verified: bool, active: bool, groups: List[Group]) -> None:
        self.id = id
        self.phone = phone
        self.app_id = app_id
        self.verified = verified
        self.active = active
        self.groups = groups


class Data:
    profile: Profile

    def __init__(self, profile: Profile) -> None:
        self.profile = profile


class Welcome:
    data: Data

    def __init__(self, data: Data) -> None:
        self.data = data
