Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from smtp-out-so.shaw.ca (smtp-out-so.shaw.ca [64.59.136.138])
 by sourceware.org (Postfix) with ESMTPS id 78EF73857C48
 for <cygwin-patches@cygwin.com>; Sat, 11 Jul 2020 04:13:54 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 78EF73857C48
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=brian.inglis@systematicsw.ab.ca
Received: from BWINGLISD.cg.shawcable.net ([24.64.172.44])
 by shaw.ca with ESMTP
 id u6tcjTsTcYYpxu6tdjEzVT; Fri, 10 Jul 2020 22:13:53 -0600
X-Authority-Analysis: v=2.3 cv=OubUNx3t c=1 sm=1 tr=0
 a=kiZT5GMN3KAWqtYcXc+/4Q==:117 a=kiZT5GMN3KAWqtYcXc+/4Q==:17
 a=VAVI7avi-4p2PNOo0hMA:9
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: cygwin-patches@cygwin.com
Subject: [PATCH] cygport announce SMTP HELO fails without smtp server FQDN
Date: Fri, 10 Jul 2020 22:13:11 -0600
Message-Id: <20200711041310.24880-1-Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.27.0
Reply-To: cygwin-patches@cygwin.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfBEyFW5RynofF//a/Aw2wxZuC90vzrx0Uowf84sBh7BAljEzwT3QO1SyWFeqWudxtqi9yQ22qXxtGJsx8ZEYCUIn698CxQwAZ4v5ITb79OltI23ezMS1
 qmu7fYm1wPkv9UzmO5YtOGtASWfR4X3e+zP8OBQzTqhFFY73UtcTPH3e2DChIpTg/RSrdo4+e+qDTq0yVyFMeltCz61usWbq01KCPC0FGEMuRaW3eKO0Wdo8
 4k/IhJb16SPFjoeEpPQpjA==
X-Spam-Status: No, score=-14.1 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_LOW,
 RCVD_IN_MSPIKE_BL, RCVD_IN_MSPIKE_L3, SPF_HELO_NONE, SPF_NONE,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Sat, 11 Jul 2020 04:13:56 -0000

pkg_upload.cygpart(__pkg_announce): added perl code to embedded perl
script for email domain FQDN copied from git send-email with minor hooks
---
 lib/pkg_upload.cygpart | 51 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/lib/pkg_upload.cygpart b/lib/pkg_upload.cygpart
index f88525d..06024b4 100644
--- a/lib/pkg_upload.cygpart
+++ b/lib/pkg_upload.cygpart
@@ -168,6 +168,7 @@ EOF
 	echo "Upload complete."
 }
 
+
 __pkg_announce() {
 	local msg=$(mktemp -t cygwin-announce-${PF}.XXXXXX)
 	local msgat=$(date +@%s)
@@ -198,7 +199,52 @@ _EOF
 
 	${EDITOR:-vi} $msg || error "Editor exited abormally, aborting annoucement"
 
+# FQDN from git send-email
+# Returns the local Fully Qualified Domain Name (FQDN) if available.
+#
+# Tightly configured MTAa require that a caller sends a real DNS
+# domain name that corresponds the IP address in the HELO/EHLO
+# handshake. This is used to verify the connection and prevent
+# spammers from trying to hide their identity. If the DNS and IP don't
+# match, the receiving MTA may deny the connection.
+#
+# Here is a deny example of Net::SMTP with the default "localhost.localdomain"
+#
+# Net::SMTP=GLOB(0x267ec28)>>> EHLO localhost.localdomain
+# Net::SMTP=GLOB(0x267ec28)<<< 550 EHLO argument does not match calling host
+#
+# This maildomain*() code is based on ideas in Perl library Test::Reporter
+# /usr/share/perl5/Test/Reporter/Mail/Util.pm ==> sub _maildomain ()
+
 	perl <(cat <<EOF
+sub valid_fqdn {
+	my \$domain = shift;
+	return defined \$domain && !(\$^O eq 'darwin' && \$domain =~ /\.local\$/) && \$domain =~ /\./;
+}
+sub maildomain_net {
+    use Net::Domain ();
+	my \$maildomain;
+	my \$domain = Net::Domain::domainname();
+	\$maildomain = \$domain if valid_fqdn(\$domain);
+	return \$maildomain;
+}
+sub maildomain_mta {
+	my \$maildomain;
+	for my \$host (qw(mailhost localhost)) {
+		my \$smtp = Net::SMTP->new(\$host);
+		if (defined \$smtp) {
+			my \$domain = \$smtp->domain;
+			\$smtp->quit;
+			\$maildomain = \$domain if valid_fqdn(\$domain);
+			last if \$maildomain;
+		}
+	}
+	return \$maildomain;
+}
+sub maildomain {
+	return maildomain_net() || maildomain_mta() || 'localhost.localdomain';
+}
+
 use strict;
 use MIME::Parser;
 use Net::SMTP;
@@ -214,7 +260,9 @@ my \$entity = \$parser->parse_open("$msg");
 
 print "Sending announcement of ${NAME}-${PVR} via \$smtp_server\n";
 
+my \$smtp_domain ||= maildomain();  # get FQDN and add Hello below
 my \$smtp = new Net::SMTP(\$smtp_server,
+			  Hello => \$smtp_domain,
 			  ${SMTP_SERVER_PORT+Port => ${SMTP_SERVER_PORT},}
 			  SSL => \$smtp_encryption eq 'ssl')
 	 or die "No mailserver at ".\$smtp_server;
@@ -224,7 +272,8 @@ if (\$smtp_encryption eq 'tls') {
 	\$smtp->response();
 	\$smtp->code == 220 or die "$server does not support STARTTLS";
 	\$smtp = Net::SMTP::SSL->start_SSL(\$smtp) or die "STARTTLS failed";
-	\$smtp->hello(\$smtp_server);
+	# Send EHLO again to receive fresh supported commands
+	\$smtp->hello(\$smtp_domain);
 }
 if (defined \$smtp_user) {
 	use Authen::SASL qw(Perl);
-- 
2.27.0

