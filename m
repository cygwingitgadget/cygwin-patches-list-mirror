From: "Jason Gouger" <cygwin@jason-gouger.com>
To: <cygwin-patches@cygwin.com>
Subject: RE: PATCH: getcwd() pathstyle
Date: Mon, 08 Jan 2001 00:37:00 -0000
Message-id: <GIEAKOJACGCDOHKHFLIHMEIECAAA.cygwin@jason-gouger.com>
References: <20010107231202.A24911@redhat.com>
X-SW-Source: 2001-q1/msg00017.html

> 1) Check out this link for the correct formatting of ChangeLog entries:

Here's the corrected ChangeLog:

Sun Jan 7 18:45:22 2001  Jason Gouger <cygwin@jason-gouger.com>

* environ.cc (known): new configuration entry pathstyle.
* winsup.h (pathstyle_start_init): header definition for new function.
* path.cc (pathstyle): enumerated type definition/declaration for pathstyle.
(pathstyle_start_init): new function to initialize pathstyle configuration.
(getcwd): change to return different pathstyles, 'posix' /usr/local/bin,
'win32' C:/cygwin/usr/local/bin, and 'dos' C:\cygwin\usr\local\bin.
