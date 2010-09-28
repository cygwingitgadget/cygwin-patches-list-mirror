Return-Path: <cygwin-patches-return-7117-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25351 invoked by alias); 28 Sep 2010 14:57:02 -0000
Received: (qmail 25337 invoked by uid 22791); 28 Sep 2010 14:57:01 -0000
X-SWARE-Spam-Status: No, hits=-0.5 required=5.0	tests=AWL,BAYES_50,T_RP_MATCHES_RCVD
X-Spam-Check-By: sourceware.org
Received: from etr-usa.com (HELO etr-usa.com) (130.94.180.135)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 28 Sep 2010 14:56:53 +0000
Received: (qmail 11987 invoked by uid 13447); 28 Sep 2010 14:56:52 -0000
Received: from unknown (HELO [172.20.0.42]) ([71.213.151.142])          (envelope-sender <warren@etr-usa.com>)          by 130.94.180.135 (qmail-ldap-1.03) with SMTP          for <cygwin-patches@cygwin.com>; 28 Sep 2010 14:56:51 -0000
Message-ID: <4CA20212.7050207@etr-usa.com>
Date: Tue, 28 Sep 2010 14:57:00 -0000
From: Warren Young <warren@etr-usa.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.2.9) Gecko/20100915 Thunderbird/3.1.4
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Cygwin Filesystem Performance degradation 1.7.5 vs 1.7.7, and methods for improving performance
References: <4C84B9EF.9030109@gmail.com> <20100906132409.GB14327@calimero.vinschen.de> <4C8E0EED.4000606@gmail.com> <20100914093859.GB15121@calimero.vinschen.de> <4C999916.7080609@gmail.com> <20100922134412.GA4817@ednor.casa.cgf.cx>
In-Reply-To: <20100922134412.GA4817@ednor.casa.cgf.cx>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q3/txt/msg00077.txt.bz2

On 9/22/2010 7:44 AM, Christopher Faylor wrote:
>
> What is /mnt/hgfs/C in this case?  How is it mounted?

HGFS is the Host-Guest File System, a VMware technology that lets it 
export host volumes to the guest in a high-speed way.

If you used old versions of VMware Workstation for Linux, you may 
remember that they used to ship a version of Samba to export Linux-side 
filesystems to the Windows guest.  Now they use their proprietary HGFS 
technology instead.  In addition to being smaller and faster than Samba, 
it works with all supported host and guest combinations, and it removes 
a dependency.

I believe Yoni's point is that the

     Linux guest -> HGFS/VMware -> Windows native

path apparently has less code in it than the

     Cygwin -> Windows native

code path.
