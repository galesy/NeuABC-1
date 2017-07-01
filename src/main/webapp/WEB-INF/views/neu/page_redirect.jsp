<script >
document.location.href="<%=request.getAttribute("redirect")==null?"":((String)request.getAttribute("redirect"))%>";
</script>