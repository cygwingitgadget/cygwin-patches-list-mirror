Return-Path: <cygwin-patches-return-9112-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 93062 invoked by alias); 5 Jul 2018 18:38:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 93051 invoked by uid 89); 5 Jul 2018 18:38:13 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-1.8 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW autolearn=no version=3.3.2 spammy=died
X-HELO: smtp-out-no.shaw.ca
Received: from smtp-out-no.shaw.ca (HELO smtp-out-no.shaw.ca) (64.59.134.13) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 05 Jul 2018 18:38:11 +0000
Received: from [192.168.1.100] ([24.64.240.204])	by shaw.ca with ESMTP	id b98qfKomFogHjb98rf2sSQ; Thu, 05 Jul 2018 12:38:09 -0600
Reply-To: Brian.Inglis@SystematicSw.ab.ca
Subject: Re: Why /dev/kmsg was deleted from cygwin1.dll in git?
To: cygwin-patches@cygwin.com
References: <20180704044424.813ee03eff360d6bcb58446b@nifty.ne.jp> <20180704105420.GN3111@calimero.vinschen.de> <20180704220138.26b42dc96fb1b49a9dc693d2@nifty.ne.jp> <20180704145247.GS3111@calimero.vinschen.de> <20180706002924.1b29830bd08668a067509508@nifty.ne.jp>
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Openpgp: preference=signencrypt
Message-ID: <542e03d3-b4ee-18b1-7ab5-2b28e37aed17@SystematicSw.ab.ca>
Date: Thu, 05 Jul 2018 18:38:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180706002924.1b29830bd08668a067509508@nifty.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2018-q3/txt/msg00007.txt.bz2

On 2018-07-05 09:29, Takashi Yano wrote:
> On Wed, 4 Jul 2018 16:52:47 +0200 Corinna Vinschen wrote:
>> Hang on.  /dev/kmsg was implemented using a mailslot and it was never
>> accessible via the syslog(3) interface.  The code you removed has
>> nothing to do with /dev/kmsg.
> 
> First of all, /dev/kmsg was not guilty. The real culprit is the code
> I had removed by the previous patch.
> 
> However, the patch I posted was based on mis-understanding regarding
> AF_UNIX implementation. I had checked fhandler_socket_unix.cc and
> thought cygwin AF_UNIX socket is implemented not using AF_INET socket.
> On the other hand, the code, I removed, checks existence of UDP socket
> to determine whether syslogd is activated. So I thought this is no
> longer correct and should be removed.
> 
> As a matter of fact, cygwin AF_UNIX socket usually use fhandler_socket_
> local.cc, in which AF_UNIX socket is implemented using AF_INET socket.
> That is, the obove understanding was incorrect.
> 
>> What the code does is to check if we have a listener on the /dev/msg UDP
>> socket, otherwise log data may get lost or, IIRC, the syslog call may
>> even hang.  So removing this code sounds like a bad idea.
> 
> In the case of syslogd is not activated, /dev/log does not exist.
> So connect() results in an error. Therefore log data is directed to 
> windows event logging mechanism even without the removed code. In
> usual case, no problem happens. However if syslogd is killed by signal
> 9 or died accidently, /dev/log remains without listener. In this case,
> the problem you mentioned may happen.
> 
>> Can you please explain *why* removing this code helps and what happens
>> if syslogd is not running after removing the code?
> 
> OK. First, connect_syslogd() tries to connect to syslogd via /dev/log
> which is created by syslogd. However, the code which I removed can not
> perform checking existence of syslogd as expected.
> Previously, get_inet_addr() is used to get name information of the socket
> opened by syslogd. This was working correctly at that time. Currently,
> getsockname() is used instead. This does not return name infomation of
> the socket on syslogd side but returns that of client side. Since no
> listener exists for this socket, it is not listed in the table returned
> by GetUdpTable(). Therefore this check results in false.
> 
> As a result, current connect_syslogd() code gives up to connect to syslogd.
> 
> To fix this, I made a new patch attached. In this patch, get_inet_addr_local()
> is used instead of getsockname() as in the past.
> 
> I will appreciate any comments.

Isn't this moot as the supported package is syslog-ng, which seems to work okay?

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada
