Return-Path: <SRS0=1UnV=AS=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	by sourceware.org (Postfix) with ESMTPS id 65BF74BA23D0
	for <cygwin-patches@cygwin.com>; Sat, 14 Feb 2026 00:36:18 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 65BF74BA23D0
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 65BF74BA23D0
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.17
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1771029378; cv=none;
	b=mvxBjX2j9HwOh+pdewLOXnVNSHObNOprZ64IVjDgh+o/GZyGgVrjlYnJ/hddhGA0Qyd9umELTGTQjMskBIZq7uzbhdvE0cbB1yy8WV/FiSVOwPDyg48cD0NtNYJjaNQP63lgUbPqJX/qVBDjmLKEeiVT1TWoZRL6QfTJphvOG4c=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1771029378; c=relaxed/simple;
	bh=jpvSwa/A4pNNZG+Fuu8PTQ34op8UqgdTGgWnZ7Au8Bc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:DKIM-Signature; b=FQgNgFJMmw4J/imVH6EsZc9ksNWpurZTz065GNryacQDw0WLuF092yVhBHjHsM39YRqIvlQEEIVBh9TN6y0oaiqE4Xm8dxLXmxyPGj7oz/0KgOWDMloOwx9uDMNbEG+Z3+aXtut9MmfQnmrR4cdfFr+NJ932jKwDv5ELdlHFpZU=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 65BF74BA23D0
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=Zukt/IKz
Received: from omf11.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 01C455A84A
	for <cygwin-patches@cygwin.com>; Sat, 14 Feb 2026 00:36:17 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf11.hostedemail.com (Postfix) with ESMTPA id 87E0320029
	for <cygwin-patches@cygwin.com>; Sat, 14 Feb 2026 00:36:16 +0000 (UTC)
Message-ID: <b081744f-c953-4ca2-bdc9-fdd260acb494@SystematicSW.ab.ca>
Date: Fri, 13 Feb 2026 17:36:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/3] Cygwin: improve PCA workaround
Content-Language: en-CA
To: cygwin-patches@cygwin.com
References: <20260126111345.386303-1-corinna-cygwin@cygwin.com>
 <20260126111345.386303-4-corinna-cygwin@cygwin.com>
Organization: Systematic Software
In-Reply-To: <20260126111345.386303-4-corinna-cygwin@cygwin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 87E0320029
X-Stat-Signature: em5ebcsmsaqy4cogznb9n9mabersyctz
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX1+SdfQ0CYMOj+2+KOvoJ0FK6rJX4paATQs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=message-id:date:mime-version:from:reply-to:subject:to:references:in-reply-to:content-type:content-transfer-encoding; s=he; bh=nUZIQ2Xjzx03Xuo1AOJ0dIh3J/TGUaozO6faUHdLQpU=; b=Zukt/IKzg3+omQBzBhZuGRnNYGmgMlMfcl9szpLHwqz7AwhdOvejQf6sK22SbiwmvIXC/KPJt45AOHlFR1qdVRqEv1jNytE6IKvpvSoZjhcoAEyaLBDrrCPW3W10LvhB0Cii0IcrG9KiBldWtJBPCtqtAdzD0igzOfoghA8DXeW5v7D3IQXvJm/NM1WzS6XDA4Oa+RKXUHTcBJ1OikgCjjq/sZnVPJt076JhsBrmAJyvHJkW2PnUZrq5F3nbCPkwHSpO2R6Y6HCgScronjZwW+lxsJP4akXplrayR/awNyvscR9tYn4SN9NyzYUx6SribZTJ5X7gZ4pxC80WaXv2dg==
X-HE-Tag: 1771029376-792709
X-HE-Meta: U2FsdGVkX18Efh1w6cULi3MXbC2OlGf/QhH6AJX53N8dIiKyKD/KpmftJmK2qGvV87bTM8X4KuGvUrn7dGXh/9RDEWMGF9MINTEBRXz/XDMbVophGAt0+qfwuxBXLG+4g7veU/VYY/rjuzZ0KYE09ML2eNB/RvI2q3EM3Z5QWfLpDX13IuQg0RveAJBHUnBiSLKwLYKI91QbDzm/vh1/LL+FiyFRm9PBWpBKfVbe7rpFrzK6gkYsGjRSZwk0oKbZdn48LlSZQDiTxWHBoAaDJKDDzC1cYRgBmyQQqphcxia3hN+i29C9fmXnE8YNR1KKZXLyq4GSJuLAAmdOqcyYNydb9EHsZ4ZRAebF77jH+INCwVpARSdLmg==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2026-01-26 04:13, Corinna Vinschen wrote:
> From: Corinna Vinschen <corinna@vinschen.de>

> Perform the check only if we're the root process of a Cygwin process
> tree.  If we start mintty from Cygwin, the PCA trigger doesn't occur.

> diff --git a/winsup/cygwin/dcrt0.cc b/winsup/cygwin/dcrt0.cc
> index 1d5a452b4fbc..e080aa41bca2 100644
> --- a/winsup/cygwin/dcrt0.cc
> +++ b/winsup/cygwin/dcrt0.cc
> @@ -253,6 +253,17 @@ frok::parent (volatile char * volatile stack_here)
>        systems. */
>     c_flags |= CREATE_UNICODE_ENVIRONMENT;
>   
> +  /* Despite all our executables having a valid manifest, "mintty" still
> +     triggers the "Program Compatibility Assistant (PCA) Service" for
> +     some reason, maybe due to some heuristics in PCA.
All makes sense and looks reasonable to a non-Windows type!

There are no differences between the windows or either mingw64 default 
manifests, but mintty has extra, after tweaking its order and layout to match, 
so perhaps something there needs updated in GH:

$ diff res.mft default-manifest.mft
--- res.mft	2026-02-13 17:21:21.491931500 -0700
+++ default-manifest.mft	2026-02-13 17:18:08.759527200 -0700
@@ -3,40 +3,22 @@
    <trustInfo xmlns="urn:schemas-microsoft-com:asm.v3">
      <security>
        <requestedPrivileges>
-        <requestedExecutionLevel level="asInvoker" uiAccess="false"/>
+        <requestedExecutionLevel level="asInvoker"/>
        </requestedPrivileges>
      </security>
    </trustInfo>
--
-  <dependency>
-    <dependentAssembly>
-      <assemblyIdentity
-        type="win32"
-        name="Microsoft.Windows.Common-Controls"
-        version="6.0.0.0"
-        publicKeyToken="6595b64144ccf1df"
-        language="*"
-        processorArchitecture="*"
-      />
-    </dependentAssembly>
-  </dependency>
-  <asmv3:application xmlns:asmv3="urn:schemas-microsoft-com:asm.v3">
-    <asmv3:windowsSettings>
-      <dpiAware 
xmlns="http://schemas.microsoft.com/SMI/2005/WindowsSettings">true</dpiAware>
-      <dpiAwareness 
xmlns="http://schemas.microsoft.com/SMI/2016/WindowsSettings">PerMonitorV2</dpiAwareness>
-    </asmv3:windowsSettings>
-  </asmv3:application>
  </assembly>

Cygwin seems to have no mintty repos available!
Perhaps GH mintty/mintty should be mirrored on sourceware?

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retrancher  but when there is no more to cut
                                 -- Antoine de Saint-Exupéry
