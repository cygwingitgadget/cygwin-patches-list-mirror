Return-Path: <cygwin-patches-return-3079-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 10932 invoked by alias); 22 Oct 2002 17:35:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 10922 invoked from network); 22 Oct 2002 17:35:23 -0000
Message-ID: <3DB58CBD.87B2BDD8@ieee.org>
Date: Tue, 22 Oct 2002 10:35:00 -0000
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Avoiding /etc/passwd and /etc/group scans
References: <3DB416E7.99E22851@ieee.org> <20021021162246.GC15828@redhat.com> <20021022162432.GF514@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q4/txt/msg00030.txt.bz2

Christopher Faylor wrote:
>
> I've checked this in.  If this solves the majority of the ntsec complaints,
> I may even send you a medal.
>  
> If I had any idea that turning on ntsec by default would cause this much
> pain, I don't think I would have considered it.

Thanks. By the way the patch can be tested by screwing up the passwd file.
Delete your sid or (more simply) add a "," at the end. Everything should
still work as before for you, if your Windows name == Cygwin name, except 
you will be unable to ssh into the system. 
You can also delete your passwd entry altogether.

I keep watching the list and I have identified other solvable 
issues. I have fixes, but they are more substantial than this patch. 
I was going to to submit them after Corinna comes back, as they
overlap the uid == gid patch I had sent just before she left.

Pierre
