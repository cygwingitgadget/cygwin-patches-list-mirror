Return-Path: <cygwin-patches-return-3223-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6209 invoked by alias); 24 Nov 2002 14:23:05 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6199 invoked from network); 24 Nov 2002 14:23:04 -0000
Message-Id: <3.0.5.32.20021124092120.00829650@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com
Date: Sun, 24 Nov 2002 06:23:00 -0000
To: Corinna Vinschen <cygwin-patches@cygwin.com>
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Re: More passwd/group patches
In-Reply-To: <20021124140414.Z1398@cygbert.vinschen.de>
References: <3DDE4528.3BDCDCEF@ieee.org>
 <3DDE3FB9.2AFAA199@ieee.org>
 <20021122154644.N1398@cygbert.vinschen.de>
 <3DDE4528.3BDCDCEF@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2002-q4/txt/msg00174.txt.bz2

At 02:04 PM 11/24/2002 +0100, you wrote:

Hi Corinna,

First off I am going to look at the Win98 home directory problem 
reported on the list, if you have not fixed it already.

>Hi Pierre,
>
>a few comments:
>
>On Fri, Nov 22, 2002 at 09:54:32AM -0500, Pierre A. Humblet wrote:
>
>A formatting nit:

OK, note taken.
>
>I don't like the idea that these DENY bits are still set when the acl is
>returned to the application.  The underlying Solaris acl implementation 
>doesn't know about these bits.  They should be removed before returning
>the acl to the application.  Otherwise you're using bits which are not
>defined in acl.h.

That had crossed my mind. In fact acl.h does not declare any values for
the a_perm field. Cygwin is simply reproducing the bits in the 
user, group and other fields. I searched the web and saw that other
versions of unix did not even agree on the type of the a_perm field (Cygwin
makes it mode_t) and that the now-defunct standard proposal was silent on the 
issue. So it seemed to me that all that mattered was consistency with
the implementation of the routines getfacl, setfacl, etc... 
I have no problem with masking them off. Defining specific bits in acl.h 
would be nice in theory, but in absence of a standard perhaps not useful.
>
>
>You're copying the group bits to the mask?  Didn't you suggest to set
>it to rwx?  I think you're right.  It would be better to move this line
>to the initialization of the first lacl members and change it to
>
Yes, but not knowing the reason for the current behavior I didn't want
to change it. It doesn't hurt anything.
>
>Same here, shouldn't the DEF_CLASS_OBJ entry have rwx, too?
>
Same answer!

Pierre
