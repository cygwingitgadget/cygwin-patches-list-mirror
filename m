From: Corinna Vinschen <vinschen@cygnus.com>
To: cygpatch <cygwin-patches@sources.redhat.com>
Subject: [PATCH]: acl_worker didn't work correctly
Date: Fri, 21 Jul 2000 03:23:00 -0000
Message-id: <397824B2.F2D6A418@cygnus.com>
X-SW-Source: 2000-q3/msg00020.html

I have patched acl_worker in security.cc to use the same set of
suffixes (which are "", ".exe" for now) as stat_worker uses.

The missing suffix check leads to a different behaviour of access()
when ntsec is ON. In that case, access() calls acl_access() which
in turn calls acl() to get the ACL of the file to check the users
permissions. acl_worker() calls path_conv and up to today it called
path_conv without checking for the exe suffix.

Corinna

-- 
Corinna Vinschen
Cygwin Developer
Cygnus Solutions, a Red Hat company
