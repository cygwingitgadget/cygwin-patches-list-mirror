Return-Path: <cygwin-patches-return-3264-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29406 invoked by alias); 2 Dec 2002 16:32:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 29397 invoked from network); 2 Dec 2002 16:32:42 -0000
Message-ID: <3DEB8AD3.3040108@ece.gatech.edu>
Date: Mon, 02 Dec 2002 08:32:00 -0000
From: Charles Wilson <cwilson@ece.gatech.edu>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: Re: --enable-runtime-pseudo-reloc support in cygwin, take 3.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q4/txt/msg00215.txt.bz2

Two issues:  (1) the licensing "problem", (2) the advisability of mingw 
pseudo-reloc.  Item (2) here, item (1) in an earlier message.

One thing that does worry me, though, is the more we rely on special 
runtime tricks and hackish pei-x86 "extensions", the more fragile the 
whole system becomes.  And the easier it is for MS to (deliberately, or 
accidentally) wreck the whole house of cards.

Not to mention the fact that mingw DLLs are quickly becoming unusable 
with non-gcc.  *I* don't care, but I wonder if the mingw folks are 
thinking about this problem: is it really advisable to use auto-import 
and runtime-pseudo-reloc and link-directly-to-dll(as long as you have 
the fancy GNU linker) so much?  It ghettoizes mingw.  (cygwin is already 
ghettoized; we're used to it: cygwin dlls can be linked-against only 
when using cygwin tools)

In other words, the more frequently these special GNU linker features 
are used by the mingw folks, the more often the resulting libraries will 
be unusable by other compilers (MSVC).  DLLs will ONLY be linkable by 
mingw-ld.  Folks will take advantage of the nice mingw-ld, and stop 
porting libraries the MSVC way -- no more declspec(__dllimport__) etc -- 
which means that libraries will gradually be compilable on windows ONLY 
if mingw is used, and not if MSVC (which still requires the declspec() 
stuff).

Is this a direction mingw wants to go?

(Except for the fragility argument (Windows ain't done 'til cygwin won't 
run) this doesn't affect cygwin; it's a mingw concern only. )

--Chuck

