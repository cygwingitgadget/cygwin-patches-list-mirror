From: DJ Delorie <dj@delorie.com>
To: fujieda@jaist.ac.jp
Cc: cygwin-patches@sourceware.cygnus.com
Subject: Re: Add some defines in winnt.h.
Date: Tue, 13 Jun 2000 19:30:00 -0000
Message-id: <200006140230.WAA29671@envy.delorie.com>
References: <s1saegpq9xb.fsf@jaist.ac.jp>
X-SW-Source: 2000-q2/msg00099.html

(1) That's not the proper format for a ChangeLog entry.  Please see
the existing ChangeLog entries for examples.  Your submission should
include the line with the date, your name, and email too.

(2) the w32api directory is imported from MinGW.  Any patches should
be sent there first, accepted, and *then* applied to cygwin.  Patches
made only to Cygwin will be lost when the next MinGW merge happens.

If these *are* updates from MinGW, please state so.
