From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: [PATCH]: Extend ntsec behaviour
Date: Wed, 25 Apr 2001 03:20:00 -0000
Message-id: <20010425122030.L23753@cygbert.vinschen.de>
X-SW-Source: 2001-q2/msg00156.html

Hi,

I have just checked in a rather big change to Cygwin (for 1.3.2) which
basically adds the following to Cygwin:

- A new class `cygsid'. It's used at places where otherwise a PSIDs and
  a char buffer is needed.

- Two new functions `internal_getpwent()' and `internal_getgrent(index)'
  to walk through the passwd and group lists inside of Cygwin. Up to now
  the ntsec related code used getpwent and getgrent which can break
  applications (*gulp*). I have found that error this morning and I'm
  already busy with hitting myself with a stick...
  Anyway, if somebody needs to walk through the passwd and group lists
  inside of Cygwin please use only these two new functions from now on.

- The three functions which are in front when the user context should
  change (setegid, seteuid) or when a Cygwin process has been started
  from a non Cygwin process (internal_getlogin) try to manipulate the
  process token resp. the impersonation token so that the following
  is done if ntsec is ON and if not an error occurs:

  - internal_getlogin: The processes token owner is set to the same value
    as the token user and if the process is started from a non Cygwin
    process the token primary group is set to the group which is given as
    primary group in /etc/passwd.

  - setegid: The processes token primary group is set to the group given
    as parameter.

  - seteuid: The impersonation token owner is set to the same value as
    the token user and the token primary group is set to the group
    currently set to the processes primary group.

  The reasoning behind these changes is the style in which NT sets the
  process token by default. Example for a user which is member of the
  administrators group and which logged in via sshd running as service
  on a workstation which is not in a domain:

  Process token:

    User:
    	S-1-5-21-1644491937-764733703-1343024091-1001  <- Yep, that's me

    Owner:
    	S-1-5-32-544   <- Hmm, owner is administrators group

    Primary Group:
    	S-1-5-21-1644491937-764733703-1343024091-513  <- "None"

    Suplementary Groups:
	S-1-5-21-1644491937-764733703-1343024091-513
	S-1-1-0
	S-1-5-32-544
	S-1-5-32-545
	S-1-5-5-0-170088991
	S-1-2-0
	S-1-5-6
	S-1-5-11

  The result of this token is that eg. files are owned by the admins
  group and the group is None.

  I don't want this. I want the files owned by me and the primary group
  set to admins. Non-admin users don't have the owner!=user problem
  but the primary group in the process token is always set to "None"
  regardless of the settings in the user manager. Primary group management
  is unfortunately only supported by NT domains.

  But we can do this by ourselves. So my change results in the following
  process token, assuming that I have set the admins group as my primary
  group in /etc/passwd:

    User:
    	S-1-5-21-1644491937-764733703-1343024091-1001  <- Yep, that's me

    Owner:
    	S-1-5-21-1644491937-764733703-1343024091-1001  <- :-)

    Primary Group:
    	S-1-5-32-544 :-)

    Suplementary Groups:
	S-1-5-21-1644491937-764733703-1343024091-513
	S-1-1-0
	S-1-5-32-544
	S-1-5-32-545
	S-1-5-5-0-170088991
	S-1-2-0
	S-1-5-6
	S-1-5-11

  As an interesting extension, I can set my primary group now to
  each group which is in the tokens supplementary group list in
  the running process by calling `setegid'.

Since I'm in the process to restructure the whole setuid/setgid
mechanism with an extension to allow changing user context without
passwords, that code is subject to further changes but it already
shows where the train goes.

Bug reports, bug fixes and criticism is welcome. Hmm, the last one
isn't really welcome but probably needed.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
