From: Christopher Faylor <cgf@redhat.com>
To: cygwin-apps@cygwin.com, cygwin-patches@cygwin.com
Subject: Re: setup.exe crashs / setup.ini patch for perl
Date: Wed, 26 Sep 2001 09:43:00 -0000
Message-id: <20010926124341.B22544@redhat.com>
References: <3BB1A27D.4773.50774CA1@localhost> <002e01c1467b$ba63f800$0200a8c0@lifelesswks> <004801c14680$2877c2a0$0200a8c0@lifelesswks>
X-SW-Source: 2001-q3/msg00203.html

Please check this in, if you haven't already.

Thanks.

cgf

On Wed, Sep 26, 2001 at 09:41:18PM +1000, Robert Collins wrote:
>This patch (against cvs) should fix it all.
>
>Index: choose.cc
>===================================================================
>RCS file: /cvs/src/src/winsup/cinstall/choose.cc,v
>retrieving revision 2.47
>diff -u -p -r2.47 choose.cc
>--- choose.cc 2001/08/05 01:38:46 2.47
>+++ choose.cc 2001/09/26 11:38:14
>@@ -803,7 +803,10 @@ _view::insert_pkg (Package *pkg)
>        /* this should be a generic call to list_sort_cmp */
>        if (lines[n].get_category ()
>     && cat->name == lines[n].get_category ()->name)
>+  {
>     insert_under (n, line);
>+    n = nlines;
>+  }
>        n++;
>      }
>    if (n == nlines)
>Index: iniparse.y
>===================================================================
>RCS file: /cvs/src/src/winsup/cinstall/iniparse.y,v
>retrieving revision 2.11
>diff -u -p -r2.11 iniparse.y
>--- iniparse.y 2001/08/05 01:38:46 2.11
>+++ iniparse.y 2001/09/26 11:38:14
>@@ -188,6 +188,8 @@ register_category (char *name)
>  }
>       else
>  {
>+   tempcat->next = sortcat->next;
>+   sortcat->next = tempcat;
>    while (sortcat->next &&
>    strcasecmp(sortcat->next->name, tempcat->name) < 0)
>      {
>
>
>
>ChangeLog
>Web Sep 26 21:39:00  Robert Collins rbtcollins@hotmail.com
>
>    * choose.cc (_view::insert_pkg): Correctly exit loop.
>    * iniparse.y (register_category): Always insert new categories.
>
>Rob
>----- Original Message -----
>From: "Robert Collins" <robert.collins@itdomain.com.au>
>To: <gp@familiehaase.de>; <cygwin-apps@cygwin.com>
>Cc: <cygwin-patches@cygwin.com>
>Sent: Wednesday, September 26, 2001 9:09 PM
>Subject: Re: setup.exe crashs / setup.ini patch for perl
>
>
>> ----- Original Message -----
>> From: "Gerrit P. Haase" <gp@familiehaase.de>
>> To: <cygwin-apps@cygwin.com>
>> Cc: <cygwin-patches@cygwin.com>
>> Sent: Wednesday, September 26, 2001 5:40 PM
>> Subject: setup.exe crashs / setup.ini patch for perl
>>
>>
>> > Hi,
>> >
>> > I will be OOO (out of office:) the next week, unfortunately I will
>not
>> > be able to do more debugging on setup.exe <-> choose.cc, it just
>> starts
>> > making fun:)
>> >
>> > But some hints:
>> > ===============
>> > The original (CVS) setup.exe crashes only if you have some packages
>> with
>> > dependencies NOT installed.
>>
>> Thank you thank you thank you. I can reproduce the fault now.
>>
>> Rob
>>
>>

-- 
cgf@cygnus.com                        Red Hat, Inc.
http://sources.redhat.com/            http://www.redhat.com/
