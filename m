Return-Path: <cygwin-patches-return-3571-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16621 invoked by alias); 17 Feb 2003 16:45:27 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16612 invoked from network); 17 Feb 2003 16:45:26 -0000
Date: Mon, 17 Feb 2003 16:45:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Create new files as sparse on NT systems. (2nd try)
Message-ID: <20030217164528.GA5837@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20030213203642.GG32279@redhat.com> <20030217171533.N92334-100000@logout.sh.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030217171533.N92334-100000@logout.sh.cvut.cz>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2003-q1/txt/msg00220.txt.bz2

On Mon, Feb 17, 2003 at 05:37:20PM +0100, Vaclav Haisman wrote:
>> UNIX has a method for producing sparse files.  If this is desired functionality,
>> Cygwin should mimic that not invent a new way of doing things.
>>
>> cgf
>
>Hi,
>I have prepared another patch that implements parse files for Cygwin. It is
>smaller and, I think, even better than the previous. No new CYGWIN options.
>
>I have also been searching internet for some informations abut sparse files in
>Unix systems. It seems that if OS and file system supports it then it supports
>it without any extra system call. Some systems (SunOS) have fcntl() command
>F_FREESP that is supposed to free allocated disk space. But all unices I have
>had look at only support such combination of parameters that the deallocated
>block of space is at the end of file. In this case it works as ftruncate(). If
>I should implement this fcntl() command such that it would be able to
>deallocate disk space in a middle of a file then I would be inventing
>something new.

This looks pretty good but the cygwin convention is to use wincap
settings for this kind of thing rather than using is_winnt.  So, please
add a wincap capability to accomplish this.

cgf

>2003-02-17  Vaclav Haisman  <V.Haisman@sh.cvut.cz>
>
>	* include/winioctl.h (FSCTL_SET_SPARSE): Define.
>
>2003-02-17  Vaclav Haisman  <V.Haisman@sh.cvut.cz>
>
>	* fhandler.h: Include winioctl.h for DeviceIoControl.
>	(fhandler::open): Try to set newly created and truncated files as
>	sparse on NT systems.
