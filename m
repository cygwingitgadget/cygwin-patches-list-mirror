Return-Path: <cygwin-patches-return-3591-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20688 invoked by alias); 19 Feb 2003 00:27:05 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 20679 invoked from network); 19 Feb 2003 00:27:05 -0000
Message-ID: <00b701c2d7ad$a0cba590$78d96f83@pomello>
From: "Max Bowsher" <maxb@ukf.net>
To: "Vaclav Haisman" <V.Haisman@sh.cvut.cz>,
	<cygwin-patches@cygwin.com>
References: <20030219010610.Y52168-100000@logout.sh.cvut.cz>
Subject: Re: Create new files as sparse on NT systems. (2nd try)
Date: Wed, 19 Feb 2003 00:27:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
X-SW-Source: 2003-q1/txt/msg00240.txt.bz2

Vaclav Haisman wrote:
> On Tue, 18 Feb 2003, Gary R Van Sickle wrote:
> 
>> "Note: It is up to the application to maintain sparseness by writing
>> zeros with FSCTL_SET_ZERO_DATA", sez the Platform docs.
> 
> In this respect Windows are ahead of any recent Unix system. I wasn't
> able find any Unix/Posix syscall that would allow this unlike Windows.
> 
>> Even if you do WriteFile()s with all zeros on a sparse file, you are
>> actually hitting the disk.
> 
> Have you ever tryed the same thing in Unix environment? Writing
> buffer full of zeros with write syscall won't gain you anything
> either. All the zeros will be physicaly written onto the disk. This
> means it has the same behaviour as Unix systems.
> 
>> The only thing this patch will do AFAICS is set a bit somewhere in
>> the guts of NTFS that will be pretty much ignored.  I'm with Max, I
>> don't see the benefit and can only imagine the consequences.
> 
> I don't see any negative consequences of this patch. The only one I
> can imagine it can slow down file operations but I very very doubt it.

Could you do some tests, so we have more than conjecture to go on?

What programs actually *benefit* from sparseness?

Max.
