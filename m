Return-Path: <cygwin-patches-return-1583-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 6622 invoked by alias); 14 Dec 2001 12:41:50 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6594 invoked from network); 14 Dec 2001 12:41:47 -0000
Message-ID: <3C19F354.1E85323C@yahoo.com>
Date: Sat, 03 Nov 2001 21:27:00 -0000
From: Earnie Boyd <earnie_boyd@yahoo.com>
Reply-To: CP List <Cygwin-Patches@Cygwin.Com>
X-Mailer: Mozilla 4.77 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: setup.exe remove scripts [Was: Re: experimental texmf packages]
References: <m33d2pam3l.fsf@appel.lilypond.org> <00d501c17d93$1936c990$0200a8c0@lifelesswks> <m3zo4x7obb.fsf@appel.lilypond.org> <m38zcdssxd.fsf@appel.lilypond.org> <01a801c18036$3d447350$0200a8c0@lifelesswks> <m3itbhqowz.fsf@appel.lilypond.org> <027001c18040$c91651f0$0200a8c0@lifelesswks> <m3wuzth3l1.fsf@appel.lilypond.org> <04db01c18302$e66cae60$0200a8c0@lifelesswks> <m3667ax540.fsf@appel.lilypond.org> <20011213215355.GA20040@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2001-q4/txt/msg00115.txt.bz2

Christopher Faylor wrote:
> 
> I believe that the prompt reflects DJ Delorie's prompt preference, which
> was, apparently, two lines.
> 

I agree, although I don't dislike it.

> *I'd* prefer no prompt setting at all, actually.  I think that prompt
> setting should be up to the user or the local sysadmin.  AFAICT, even
> Red Hat doesn't try to make a prompt decision for you.
> 

I'd prefer no prompt setting also by default but leave the PS1 commented
out for an example of use.  The problem with the current PS1 is that
it's SHELL specific, I.E.: it only works in bash.

Earnie.

_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

