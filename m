Return-Path: <cygwin-patches-return-3267-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13778 invoked by alias); 2 Dec 2002 19:36:01 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13769 invoked from network); 2 Dec 2002 19:36:00 -0000
Message-ID: <20021202193515.36127.qmail@web21405.mail.yahoo.com>
Date: Mon, 02 Dec 2002 11:36:00 -0000
From: =?iso-8859-1?q?Danny=20Smith?= <danny_r_smith_2001@yahoo.co.nz>
Subject: Re: --enable-runtime-pseudo-reloc support in cygwin, take 3.
To: cygwin-patches@cygwin.com
In-Reply-To: <3DEB8AD3.3040108@ece.gatech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-SW-Source: 2002-q4/txt/msg00218.txt.bz2

 --- Charles Wilson <cwilson@ece.gatech.edu> wrote: > Two issues:  (1) the
licensing "problem", (2) the advisability of mingw 
> pseudo-reloc.  Item (2) here, item (1) in an earlier message.
> 
> One thing that does worry me, though, is the more we rely on special 
> runtime tricks and hackish pei-x86 "extensions", the more fragile the 
> whole system becomes.  And the easier it is for MS to (deliberately, or 
> accidentally) wreck the whole house of cards.
> 
> Not to mention the fact that mingw DLLs are quickly becoming unusable 
> with non-gcc.  

Not that quickly I think.

*I* don't care, but I wonder if the mingw folks are 
> thinking about this problem: is it really advisable to use auto-import 
> and runtime-pseudo-reloc and link-directly-to-dll(as long as you have 
> the fancy GNU linker) so much?  It ghettoizes mingw.  (cygwin is already 
> ghettoized; we're used to it: cygwin dlls can be linked-against only 
> when using cygwin tools)
> 
> In other words, the more frequently these special GNU linker features 
> are used by the mingw folks, the more often the resulting libraries will 
> be unusable by other compilers (MSVC).  DLLs will ONLY be linkable by 
> mingw-ld.  Folks will take advantage of the nice mingw-ld, and stop 
> porting libraries the MSVC way -- no more declspec(__dllimport__) etc -- 
> which means that libraries will gradually be compilable on windows ONLY 
> if mingw is used, and not if MSVC (which still requires the declspec() 
> stuff).
> 
> Is this a direction mingw wants to go?


Speaking-for-myself (tm):

No.  The -auto-import feature by itself hasn't raised any "it doesnt work with
MSVC anymore"  whines, mainly because most mingw users seem comfortable with
the declspec(__dllimport) habit.  I have tried to encourage that habit by
saying that auto-import is a last resort.  Personally, I use dllwrap rather
than gcc -shared as the rule rather than the exception, because it enforces
that habit  (and also because my makefile templates are already written that
way)

But, having said that, if other mingw users want to use something that breaks
MSVC compatability, why should I care.  It's their choice. 

Danny
> 
>  

http://www.yahoo.promo.com.au/hint/ - Yahoo! Hint Dropper
- Avoid getting hideous gifts this Christmas with Yahoo! Hint Dropper!
