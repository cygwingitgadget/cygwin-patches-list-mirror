Return-Path: <cygwin-patches-return-3573-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24597 invoked by alias); 17 Feb 2003 17:50:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24588 invoked from network); 17 Feb 2003 17:50:13 -0000
Message-ID: <005901c2d6ad$0446cbb0$78d96f83@pomello>
From: "Max Bowsher" <maxb@ukf.net>
To: <cygwin-patches@cygwin.com>
References: <20030213203642.GG32279@redhat.com> <20030217171533.N92334-100000@logout.sh.cvut.cz> <20030217164528.GA5837@redhat.com>
Subject: Re: Create new files as sparse on NT systems. (2nd try)
Date: Mon, 17 Feb 2003 17:50:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
X-SW-Source: 2003-q1/txt/msg00222.txt.bz2

> On Mon, Feb 17, 2003 at 05:37:20PM +0100, Vaclav Haisman wrote:
>> I have prepared another patch that implements sparse files for
>> Cygwin. It is smaller and, I think, even better than the previous.
>> No new CYGWIN options.

>> 2003-02-17  Vaclav Haisman  <V.Haisman@sh.cvut.cz>
>>
>> * include/winioctl.h (FSCTL_SET_SPARSE): Define.
>>
>> 2003-02-17  Vaclav Haisman  <V.Haisman@sh.cvut.cz>
>>
>> * fhandler.h: Include winioctl.h for DeviceIoControl.
>> (fhandler::open): Try to set newly created and truncated files as
>> sparse on NT systems.


Christopher Faylor wrote:
> This looks pretty good but the cygwin convention is to use wincap
> settings for this kind of thing rather than using is_winnt.  So,
> please add a wincap capability to accomplish this.


Is it wise to set *all* new files to sparse? Surely if this was actually
advantageous, Windows would do it anyway? From MSDN: "Note  It is up to the
application to maintain sparseness by writing zeros with
FSCTL_SET_ZERO_DATA." I.e., this will gain nothing unless the application
knows about sparse-ness, in which case, it should explicitly specify that
the file should be sparse. So, all this patch will do is to force Windows to
examine more metadata for every file read. This seems *extremely
undesirable*.

Max.
