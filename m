Return-Path: <cygwin-patches-return-2261-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 29688 invoked by alias); 30 May 2002 00:26:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 29667 invoked from network); 30 May 2002 00:26:31 -0000
Message-ID: <20020530002630.44094.qmail@web20003.mail.yahoo.com>
Date: Wed, 29 May 2002 17:26:00 -0000
From: Joshua Daniel Franklin <joshuadfranklin@yahoo.com>
Subject: Re: passwd help/version patch
To: Corinna Vinschen <cygwin-patches@cygwin.com>
In-Reply-To: <20020529091720.G30892@cygbert.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SW-Source: 2002-q2/txt/msg00244.txt.bz2

--- Corinna Vinschen <cygwin-patches@cygwin.com> wrote:
> On Tue, May 28, 2002 at 10:56:21PM -0500, Joshua Daniel Franklin wrote:
> > Here is the --help, --version patch for passwd.
> > I used the idea from a recent cygpath patch to separate usage output into
> > sections, though I feel I've improved on it a bit. :)
> > Corinna, you might want to take a look at these longopt names I chose to
> > make sure they're OK:
> 
> Cool.  Applied.
> 
> While playing with it, I'd suddenly missed a short text in the usage,
> that the username has to be the windows username, not the Cygwin
> username.  Passwd has been written before all that ntsec stuff AFAIR,
> so it has no idea that the user "Administrator" might be renamed
> to "root" in /etc/passwd.  Do you think you could add something
> appropriate?  Or perhaps change passwd to take the Cygwin name and
> convert it to the windows name???
> 
> Corinna

Maybe I'm missing something, but there doesn't seem to be any Win32 
function to get a username from a uid other than NetUserEnum, but 
I really don't think people running 'passwd bob' are wanting to enum
all users. The code to do it wouldn't be that hard, but it wouldn't
work for those people with domains (unless they specify a domain like
for mkpasswd).

Maybe mkpasswd should cache the info somewhere other than just /etc/passwd 
for this purpose? Or use the GECOS field?

__________________________________________________
Do You Yahoo!?
Yahoo! - Official partner of 2002 FIFA World Cup
http://fifaworldcup.yahoo.com
