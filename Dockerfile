FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /lrm
COPY ./LRM.Node ./
RUN dotnet publish LRM.sln --runtime ubuntu.20.04-x64 -c Release -o /out/

FROM mcr.microsoft.com/dotnet/aspnet:5.0
WORKDIR /lrm
COPY --from=build /out/ .

ENV NO_CONFIG="true"
ENV TRANSPORT_CLASS="Mirror.SimpleWebTransport"
ENV AUTH_KEY="secret"

EXPOSE 7777/udp
EXPOSE 7776/udp
EXPOSE 8080

ENTRYPOINT [ "./LRM" ]
