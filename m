From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>, <cygwin-patches@sourceware.cygnus.com>
Subject: Re: [PATCH] Setup.exe "other URL" functionality
Date: Sun, 30 Dec 2001 05:00:00 -0000
Message-ID: <062a01c19131$fb1d7000$0200a8c0@lifelesswks>
References: <NCBBIHCHBLCMLBLOBONKKEBICIAA.g.r.vansickle@worldnet.att.net>
X-SW-Source: 2001-q4/msg00364.html
Message-ID: <20011230050000.t41HzpVF9ryIhdOEjFM0lbkvJrVFEUHy38_haDDUtqc@z>

Another request: please d2u all patches before you send them: The CVS
versions are in unix format, so your patches will fail if applied on a
linux machine.

Also, your indent is changing
-bool
-PropSheet::SetActivePageByID (int resource_id)

to

+bool PropSheet::SetActivePageByID (int resource_id)

- and the first format is the correct one.


Secondly, you should run indent on all modified fiels before diffing.
Indent created differences don't need changelog entries (unless the only
change in a file is due to diff). site.cc is definately incorrectly
formatted by your patch.

Indent should be run with no options for cinstall. (It does the correct
thing here). However 2.2.7 is still very C++ broken. Sigh.

(One specific example is:
===
int
  packagedb::installeddbread =
  0;
list < packagemeta, char const *,
  strcasecmp >
  packagedb::packages;
list < Category, char const *,
  strcasecmp >
  packagedb::categories;
PackageDBActions
  packagedb::task =
  PackageDB_Install;
===

Moving along to the actual patch...
1) Whats a TCHAR? (site.cc). Is there some reason a wchar is not
appropriate? (i.e. Using gettext statically linked).
2) I don't like what you've done with the 'user URL'. The current
implementation allows the user to add 'n' arbitrary URL's, and merge
them with the downloaded list. I like the idea of combining the windows,
but the capabilities must stay the same as they are now. (ie on the
current CVS code, each time you click on 'other' the new URL is added to
the list, and added to the select URL's.). IOW it's not a boolean
user-or-offical choice, it's purely a list of URLs that are known about
and a list of select URL's. The source of the URL is irrelevant.
3) If other.[cc|h] is not needed, we should rm them.

Other than that it looks good, if you can explain 1) to me :], correct
2) and answer 3) and then send a new diff, with all modified files
indented, I'll re-review 2) and check it in. If you want to split out
the other changes from 2) and do two patches the other stuff can go in
without any more round trips.

Rob
