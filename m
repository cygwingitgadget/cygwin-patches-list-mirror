Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 by sourceware.org (Postfix) with ESMTPS id CD96C3858C52
 for <cygwin-patches@cygwin.com>; Mon,  4 Jul 2022 08:39:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org CD96C3858C52
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MTR6K-1o2p251KCy-00TpG9 for <cygwin-patches@cygwin.com>; Mon, 04 Jul 2022
 10:39:45 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id EC7EFA80BE3; Mon,  4 Jul 2022 10:39:44 +0200 (CEST)
Date: Mon, 4 Jul 2022 10:39:44 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: implement getfacl(1) for socket files
Message-ID: <YsKnUOvT/jnv/8QD@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <c16697ba-b02f-ffd1-7422-fa22443e7895@cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c16697ba-b02f-ffd1-7422-fa22443e7895@cornell.edu>
X-Provags-ID: V03:K1:IVComn8tnmYjwNpba+MN9Ne7H7hjs05vS3wx3XeP2TSGJYweZK6
 pXEHFFvvUy5ltbGpY8fi6/4Zl79BVrWX5rL11vz718Rumm70+/zsMGxUcYS2EzA53dlnkMD
 CC3N60RAbHpufpcnsSXe4KtkoKpYBQo11X8tBkGEImSR741nZLH5Eyo4sB+J1NMXn2XloQU
 o5PAL7bXJZM4PMupdZqng==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9ySWCyQt5Ck=:2i0+P7EEsL6If+wEN+K8YN
 JOXPn3mcbkQJO/1Dv9huGyz63vtCc4Hek904bBc431dAx1AwRIjwlzT6ppnyiTD4tfefuE838
 41v7viWgYKk+O66aXjMEvN4uhwwXBWa9F2xkuOCWW4MsXkGH9V840ilK9CzMvEegYRlu3dzhC
 5Tfr9o5EC8e5ogZm4wEM2Que5RjuDFBC5GwB7bej5YMiKwrh/wMAH15RjWJveBCp9vsCpTBRX
 aB2tx1469wCpz7Z9nWGr4+r/OAib6PG+uwU9fML95HSYEncMVkUR5ZBfTSeK6+oGzrmNgUSdp
 baRJo5Mzc/gaWt6zGUwXFkDIcf3PHdr4/UAYUgX0OXs8P9u3GeZkr2kpG3li+QaXdzaLL8tAY
 zuLh2bV4Qa/cP2TmM3JcjTxQ6iqyARSXUh4ZFYvBMaTpNjwHPPN/Rf5+CsvSvZS6JwgNg/pNA
 vttcWLYTaqpKh+NgOuJt02j2D020E53XQ0dSY2RMGFt1mjIMSnjWVRXeDzoqMHq9ZE1FalPRi
 lt1S1C9+u9CndcS0bVy/aXYP1mhN0PCMlGH/7Vc5RC5VJezyyJH+oOpqMV8Bc+ovUvpn1ELZt
 wXKI6zf9vbH768eWnP2wXzlHvzp5u+0egVW86OVZ3qovdZBfPe6V1Syhc787+7RtJczT4puun
 jq3T57x0ClChflSynyjfIcKIaUd5PO2XbItyHqpxTgNX0mLk6y986XUb0a13PyUxju3fV+yY0
 924DIj9qUkHP3X0OiFwbDV0Eq1/FJVg6okLR2CzjgHHpi/Ab3P5Yh+QEaWU=
X-Spam-Status: No, score=-100.9 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_FAIL, SPF_HELO_NONE, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Mon, 04 Jul 2022 08:39:48 -0000

On Jul  3 14:37, Ken Brown wrote:
> Patch attached.

LGTM, but make this master (i .e., 3.4) only.


Thanks,
Corinna


> From 28cd29d99fe6d1a54c8dad04854bda10743737d3 Mon Sep 17 00:00:00 2001
> From: Ken Brown <kbrown@cornell.edu>
> Date: Sat, 2 Jul 2022 15:12:40 -0400
> Subject: [PATCH] Cygwin: implement getfacl(1) for socket files
> 
> Do this by defining the acl_get method for the fhandler_socket_local
> and fhandler_socket_unix classes.  Also define acl_set for these
> classes.
> 
> Partially addresses: https://cygwin.com/pipermail/cygwin/2022-July/251768.html
> ---
>  winsup/cygwin/fhandler.h      |  4 ++
>  winsup/cygwin/release/3.3.6   |  3 ++
>  winsup/cygwin/sec_posixacl.cc | 76 +++++++++++++++++++++++++++++++++++
>  3 files changed, 83 insertions(+)
> 
> diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
> index d5ec56a6d..cb5e08fa3 100644
> --- a/winsup/cygwin/fhandler.h
> +++ b/winsup/cygwin/fhandler.h
> @@ -861,6 +861,8 @@ class fhandler_socket_local: public fhandler_socket_wsock
>    int fchmod (mode_t newmode);
>    int fchown (uid_t newuid, gid_t newgid);
>    int facl (int, int, struct acl *);
> +  struct __acl_t *acl_get (uint32_t);
> +  int acl_set (struct __acl_t *, uint32_t);
>    int link (const char *);
>  
>    /* from here on: CLONING */
> @@ -1143,6 +1145,8 @@ class fhandler_socket_unix : public fhandler_socket
>    int fchmod (mode_t newmode);
>    int fchown (uid_t newuid, gid_t newgid);
>    int facl (int, int, struct acl *);
> +  struct __acl_t *acl_get (uint32_t);
> +  int acl_set (struct __acl_t *, uint32_t);
>    int link (const char *);
>  
>    /* select.cc */
> diff --git a/winsup/cygwin/release/3.3.6 b/winsup/cygwin/release/3.3.6
> index 44a7bcf9d..b18691428 100644
> --- a/winsup/cygwin/release/3.3.6
> +++ b/winsup/cygwin/release/3.3.6
> @@ -26,3 +26,6 @@ Bug Fixes
>  - Fix a console problem that the text longer than 1024 bytes cannot
>    be pasted correctly.
>    Addresses: https://cygwin.com/pipermail/cygwin/2022-June/251764.html
> +
> +- Don't error out if getfacl(1) is called on a socket file.
> +  Partially addresses: https://cygwin.com/pipermail/cygwin/2022-July/251768.html
> diff --git a/winsup/cygwin/sec_posixacl.cc b/winsup/cygwin/sec_posixacl.cc
> index e7e5a9c3e..c2daa3309 100644
> --- a/winsup/cygwin/sec_posixacl.cc
> +++ b/winsup/cygwin/sec_posixacl.cc
> @@ -633,6 +633,44 @@ fhandler_disk_file::acl_get (acl_type_t type)
>    return acl;
>  }
>  
> +acl_t
> +fhandler_socket_local::acl_get (acl_type_t type)
> +{
> +  if (!dev ().isfs ())
> +    /* acl_get_fd on a socket. */
> +    return fhandler_base::acl_get (type);
> +
> +  /* acl_get_fd on a socket opened with O_PATH or acl_get_file on a
> +     socket file. */
> +  if (get_flags () & O_PATH)
> +    {
> +      set_errno (EBADF);
> +      return NULL;
> +    }
> +  fhandler_disk_file fh (pc);
> +  return fh.acl_get (type);
> +}
> +
> +#ifdef __WITH_AF_UNIX
> +acl_t
> +fhandler_socket_unix::acl_get (acl_type_t type)
> +{
> +  if (!dev ().isfs ())
> +    /* acl_get_fd on a socket. */
> +    return fhandler_base::acl_get (type);
> +
> +  /* acl_get_fd on a socket opened with O_PATH or acl_get_file on a
> +     socket file. */
> +  if (get_flags () & O_PATH)
> +    {
> +      set_errno (EBADF);
> +      return NULL;
> +    }
> +  fhandler_disk_file fh (pc);
> +  return fh.acl_get (type);
> +}
> +#endif
> +
>  extern "C" acl_t
>  acl_get_fd (int fd)
>  {
> @@ -765,6 +803,44 @@ fhandler_disk_file::acl_set (acl_t acl, acl_type_t type)
>    return ret;
>  }
>  
> +int
> +fhandler_socket_local::acl_set (acl_t acl, acl_type_t type)
> +{
> +  if (!dev ().isfs ())
> +    /* acl_set_fd on a socket. */
> +    return fhandler_base::acl_set (acl, type);
> +
> +  /* acl_set_fd on a socket opened with O_PATH or acl_set_file on a
> +     socket file. */
> +  if (get_flags () & O_PATH)
> +    {
> +      set_errno (EBADF);
> +      return -1;
> +    }
> +  fhandler_disk_file fh (pc);
> +  return fh.acl_set (acl, type);
> +}
> +
> +#ifdef __WITH_AF_UNIX
> +int
> +fhandler_socket_unix::acl_set (acl_t acl, acl_type_t type)
> +{
> +  if (!dev ().isfs ())
> +    /* acl_set_fd on a socket. */
> +    return fhandler_base::acl_set (acl, type);
> +
> +  /* acl_set_fd on a socket opened with O_PATH or acl_set_file on a
> +     socket file. */
> +  if (get_flags () & O_PATH)
> +    {
> +      set_errno (EBADF);
> +      return -1;
> +    }
> +  fhandler_disk_file fh (pc);
> +  return fh.acl_set (acl, type);
> +}
> +#endif
> +
>  extern "C" int
>  acl_set_fd (int fd, acl_t acl)
>  {
> -- 
> 2.36.1
> 

